//
//  TabBarViewModel.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

struct TabBarViewModel {
    let type: ModelType
    let tabBarItem: UITabBarItem
}

enum ModelType: Int {
    case emailed
    case shared
    case viewed
    case favorites
    
    var servise: NewsServiceProtocol {
        
        switch self {
        case .emailed:
            return EmailedService()
        case .shared:
            return SharedService()
        case .viewed:
            return ViewedService()
        case .favorites:
            return FavoritesService()
        }
    }
}
