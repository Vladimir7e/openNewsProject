//
//  EmailedCollectionViewCell.swift
//  openNewsProject
//
//  Created by Developer on 12.05.2022.
//

import UIKit

private extension CGFloat {
    static let inset: CGFloat = 20
    static let interItemSpacing: CGFloat = 20
}

class EmailedCollectionViewCell: UICollectionViewCell, ViewIdentifiable, CellSizeProtocol {

    // UI elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    // MARK: - Public

    func setup(viewModel: NewsCellViewModel) {
        titleLabel?.text = viewModel.title
    }

    // MARK: - CellSizeProtocol

    static func size(for size: CGSize, itemsPerRow: CGFloat) -> CGSize {
        let paddinWidth = (CGFloat.inset * 2) + CGFloat.interItemSpacing
        let availableWidht = size.width - paddinWidth
        let widthPerItem = availableWidht / itemsPerRow

        return CGSize(width: widthPerItem, height: 80)
    }
}
