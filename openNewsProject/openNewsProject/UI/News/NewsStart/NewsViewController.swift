//
//  EmailedViewController.swift
//  openNewsProject
//
//  Created by Developer on 08.05.2022.
//

import UIKit

protocol INewsViewController: AnyObject, ActivityIndicatorProtocol, ErrorAlertProtocol {
    func reloadData()
    func setupTopContainer(with viewModel: NewsTopContainerViewModel)
    func endRefreshing()
}

final class NewsViewController: UIViewController {
    // Dependencies
    private let sectionInserts: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let presenter: INewsPresenter
    private let cellTypeResolver: INewsCellTypeResolver

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // UI elements
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    // MARK: - Initialization
    init(
        presenter: INewsPresenter,
        cellTypeResolver: INewsCellTypeResolver
    ) {
        self.presenter = presenter
        self.cellTypeResolver = cellTypeResolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }

    // MARK: - Private
    private func setup() {
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        let nibCell: UINib = UINib(nibName: String(describing: NewsCollectionViewCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))

        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
    }
    
    @objc private func refreshData(sender: UIRefreshControl) {
        presenter.refreshData()
    }
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item: UICollectionViewDropItem = coordinator.items.first,
           let sourceIndexPath: IndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates({
                presenter.reorderItems(sourceIndexPath: sourceIndexPath.item, destinationIndexPath: destinationIndexPath.item)
                                
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}

extension NewsViewController: INewsViewController {
    func reloadData() {
        collectionView.reloadData()
    }

    func setupTopContainer(with viewModel: NewsTopContainerViewModel) {
        navigationItem.title = viewModel.title
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension NewsViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let indexTabBarVC: Int? = tabBarController?.selectedIndex
        if indexTabBarVC == 3 {
            
            var id: Int = 0
            switch presenter.viewModel.cellModels[indexPath.row] {
            case .defaultCell(let model):
                id = model.id
            }
            
            let item: String = id.description
            let itemProvider: NSItemProvider = NSItemProvider(object: item as NSString)
            let dragItem: UIDragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = item
            
            return [dragItem]
        }
        return []
    }
}

extension NewsViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath: IndexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row: Int = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.viewModel.cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: NewsCollectionViewCell.self),
            for: indexPath
        ) as? NewsCollectionViewCell else {
                return UICollectionViewCell()
        }

        let cellModel: CellViewModel = presenter.viewModel.cellModels[indexPath.row]
        switch cellModel {
        case .defaultCell(let cellViewModel):
            cell.setup(viewModel: cellViewModel)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cellModel: CellViewModel = presenter.viewModel.cellModels[indexPath.row]
        switch cellModel {
        case .defaultCell(let cellModel):
            cellModel.tapAction()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let indexTabBarVC: Int? = tabBarController?.selectedIndex
        if indexTabBarVC != 3 {
            
            let config: UIContextMenuConfiguration = UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: { () -> UIViewController? in

                let viewController: UIViewController = DescriptionAssembly().assemble(newsModel: self.presenter.news[indexPath.row])
                return viewController
            }, actionProvider: nil)
            return config
        }
        return nil
    }

    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let vc = animator.previewViewController else { return }

        animator.addCompletion {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellModel: CellViewModel = presenter.viewModel.cellModels[indexPath.row]
        let cellType: (ViewIdentifiable & CellSizeProtocol).Type = cellTypeResolver.resolveCellType(
            for: cellModel
        )

        return cellType.size(for: collectionView.frame.size, itemsPerRow: 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
