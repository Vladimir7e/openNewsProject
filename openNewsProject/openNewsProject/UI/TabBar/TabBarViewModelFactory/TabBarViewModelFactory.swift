//
//  TabBarViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation

protocol ITabBarViewModelFactory {
    func makeViewModels() -> [TabBarViewModel]
}

final class TabBarViewModelFactory: ITabBarViewModelFactory {
    
    // MARK: - ITabBarViewModelFactory
    
    func makeViewModels() -> [TabBarViewModel] {
        [
            .init(type: .emailed, tabBarItem: .init(title: NSLocalizedString("Emailed", comment: ""), image: nil, tag: 0)),
            .init(type: .shared, tabBarItem: .init(title: NSLocalizedString("Shared", comment: ""), image: nil, tag: 1)),
            .init(type: .viewed, tabBarItem: .init(title: NSLocalizedString("Viewed", comment: ""), image: nil, tag: 2)),
            .init(type: .favorites, tabBarItem: .init(title: NSLocalizedString("Favorites", comment: ""), image: nil, tag: 3))
        ]
    }
}
