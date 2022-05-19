//
//  EmailedCellTypeResolver.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation

protocol IEmailedCellTypeResolver {
    func resolveCellType(for emailedCellViewModel: EmailedCellViewModel) -> (ViewIdentifiable & CellSizeProtocol).Type
}

final class EmailedCellTypeResolver: IEmailedCellTypeResolver {
    
    func resolveCellType(for emailedCellViewModel: EmailedCellViewModel) -> (ViewIdentifiable & CellSizeProtocol).Type {
        switch emailedCellViewModel {
        case .defaultCell:
            return EmailedCollectionViewCell.self
        }
    }
}
