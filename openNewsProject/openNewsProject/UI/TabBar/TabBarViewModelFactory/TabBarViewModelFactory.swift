//
//  TabBarViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import Foundation
import Rswift

protocol ITabBarViewModelFactory {
    func makeViewModels() -> [TabBarViewModel]
}

final class TabBarViewModelFactory: ITabBarViewModelFactory {
    
    // MARK: - ITabBarViewModelFactory
    
    func makeViewModels() -> [TabBarViewModel] {
        [
            .init(type: .emailed, tabBarItem: .init(title: R.string.localizable.emailed(), image: nil, tag: 0)),
            .init(type: .shared, tabBarItem: .init(title: R.string.localizable.shared(), image: nil, tag: 1)),
            .init(type: .viewed, tabBarItem: .init(title: R.string.localizable.viewed(), image: nil, tag: 2)),
            .init(type: .favorites, tabBarItem: .init(title: R.string.localizable.favorites(), image: nil, tag: 3))
        ]
    }
}
