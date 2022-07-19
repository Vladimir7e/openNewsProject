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

    private func setup() {
        setupCollectionView()
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        let nibCell: UINib = UINib(nibName: String(describing: NewsCollectionViewCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))

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
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}

extension NewsViewController: INewsViewController {
    func reloadData() {
        collectionView.reloadData()
    }

    func setupTopContainer(with viewModel: NewsTopContainerViewModel) {
        navigationItem.title = viewModel.title
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
