//
//  TabBarViewControllersResolver.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol ITabBarViewControllersResolver {
    func resolveViewController(type: ModelType) -> UIViewController
}

final class TabBarViewControllersResolver: ITabBarViewControllersResolver {
    // MARK: - ITabBarViewControllersResolver
    func resolveViewController(type: ModelType) -> UIViewController {
        NewsAssembly().assemble(newsType: type)
    }
}
