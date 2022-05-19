//
//  TabBarAssembly.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol ITabBarAssembly {
    func assemble() -> UIViewController
}

final class TabBarAssembly: ITabBarAssembly {
    
    func assemble() -> UIViewController {
        let viewModelFactory: TabBarViewModelFactory = TabBarViewModelFactory()
        let presenter: TabBarPresenter = TabBarPresenter(
            viewModelFactory: viewModelFactory
        )
        let tabBarViewControllersResolver: TabBarViewControllersResolver = TabBarViewControllersResolver()
        let view: TabBarController = TabBarController(
            presenter: presenter,
            tabBarViewControllersResolver: tabBarViewControllersResolver
        )
        presenter.view = view

        return view
    }
}
