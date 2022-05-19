//
//  EmailedViewController.swift
//  openNewsProject
//
//  Created by Developer on 08.05.2022.
//

import UIKit

protocol IEmailedViewController: AnyObject {
    func reloadData()
    func setupTopContainer(with viewModel: EmailedTopContainerViewModel)
}

class EmailedViewController: UIViewController {

    // Dependencies
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let presenter: IEmailedPresenter
    private let cellTypeResolver: IEmailedCellTypeResolver

    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Initialization

    init(
        presenter: IEmailedPresenter,
        cellTypeResolver: IEmailedCellTypeResolver
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
        let nibCell = UINib(nibName: "EmailedCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "EmailedCollectionViewCell")

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension EmailedViewController: IEmailedViewController {
    func reloadData() {
        collectionView.reloadData()
    }

    func setupTopContainer(with viewModel: EmailedTopContainerViewModel) {
        navigationItem.title = viewModel.title
    }
}

extension EmailedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.viewModel.cellModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmailedCollectionViewCell", for: indexPath) as! EmailedCollectionViewCell

        let mostEmailed = presenter.viewModel.cellModels[indexPath.row]
        switch mostEmailed {
        case .defaultCell(let cellModel):
            cell.setup(viewModel: cellModel)
        }

        return cell
    }
}

extension EmailedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellModel: EmailedCellViewModel = presenter.viewModel.cellModels[indexPath.row]
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
