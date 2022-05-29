//
//  EmailedViewController.swift
//  openNewsProject
//
//  Created by Developer on 08.05.2022.
//

import UIKit

protocol INewsViewController: AnyObject {
    func reloadData()
    func setupTopContainer(with viewModel: NewsTopContainerViewModel)
}

final class NewsViewController: UIViewController {

    // Dependencies
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let presenter: INewsPresenter
    private let cellTypeResolver: INewsCellTypeResolver

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!

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

    private func setup() {
        let nibCell = UINib(nibName: String(describing: NewsCollectionViewCell.self), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))

        collectionView.delegate = self
        collectionView.dataSource = self
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsCollectionViewCell.self), for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }

        let cellModel = presenter.viewModel.cellModels[indexPath.row]
        switch cellModel {
        case .defaultCell(let cellViewModel):
            cell.setup(viewModel: cellViewModel)
        }

        return cell
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
