//
//  TabBarViewControllersResolver.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol ITabBarViewControllersResolver {
    func resolveViewController(type: TabBarItemType) -> UIViewController
}

final class TabBarViewControllersResolver: ITabBarViewControllersResolver {
    
    // MARK: - ITabBarViewControllersResolver
    
    func resolveViewController(
        type: TabBarItemType
    ) -> UIViewController {
        switch type {
        case .emailed:
            return EmailedAssembly().assemble()
        default:
            return EmailedAssembly().assemble() // temporary
        }
    }
}

