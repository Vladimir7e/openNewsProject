//
//  EmailedCollectionViewCell.swift
//  openNewsProject
//
//  Created by Developer on 12.05.2022.
//

import UIKit
import Kingfisher

private extension CGFloat {
    static let inset: CGFloat = 20
    static let interItemSpacing: CGFloat = 20
}

class NewsCollectionViewCell: UICollectionViewCell, ViewIdentifiable, CellSizeProtocol {

    // UI elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel?.text = ""
        imageView.image = nil
    }

    // MARK: - Public

    func setup(viewModel: NewsCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.kf.indicatorType = .activity
        guard let imagePath: String = viewModel.imagePath else {
            return
        }
        imageView.kf.setImage(with: URL(string: imagePath))
    }

    // MARK: - CellSizeProtocol

    static func size(for size: CGSize, itemsPerRow: CGFloat) -> CGSize {
        let paddinWidth = (CGFloat.inset * 2) + CGFloat.interItemSpacing
        let availableWidht = size.width - paddinWidth
        let widthPerItem = availableWidht / itemsPerRow

        return CGSize(width: widthPerItem, height: 80)
    }
}
