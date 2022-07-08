//
//  EmailedViewModel.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation

struct NewsViewModel {
    
    static let empty: NewsViewModel = .init(cellModels: [])
    
    let cellModels: [CellViewModel]
}

enum CellViewModel {
    
    case defaultCell(NewsCellViewModel)
}
