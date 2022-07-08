//
//  EmailedCellTypeResolver.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation

protocol INewsCellTypeResolver {
    func resolveCellType(for newsCellViewModel: CellViewModel) -> (ViewIdentifiable & CellSizeProtocol).Type
}

final class NewsCellTypeResolver: INewsCellTypeResolver {
    func resolveCellType(for newsCellViewModel: CellViewModel) -> (ViewIdentifiable & CellSizeProtocol).Type {
        switch newsCellViewModel {
        case .defaultCell:
            return NewsCollectionViewCell.self
        }
    }
}
