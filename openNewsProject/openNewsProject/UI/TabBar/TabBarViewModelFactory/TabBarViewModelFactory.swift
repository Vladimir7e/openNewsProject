//
//  TabBarViewModelFactory.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

protocol ITabBarViewModelFactory {
    func makeViewModels() -> [TabBarViewModel]
}

final class TabBarViewModelFactory: ITabBarViewModelFactory {
    
    // MARK: - ITabBarViewModelFactory
    
    func makeViewModels() -> [TabBarViewModel] {
        [
            .init(
                type: .emailed,
                tabBarItem: .init(
                    title:  "Emailed", image: nil, tag: 0
                )
            )
        ]
    }
}
