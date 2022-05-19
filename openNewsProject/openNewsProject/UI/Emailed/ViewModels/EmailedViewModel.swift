//
//  EmailedViewModel.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation

struct EmailedViewModel {
    static let empty: EmailedViewModel = .init(cellModels: [])
    
    let cellModels: [EmailedCellViewModel]
}

enum EmailedCellViewModel {
    case defaultCell(NewsCellViewModel)
}
