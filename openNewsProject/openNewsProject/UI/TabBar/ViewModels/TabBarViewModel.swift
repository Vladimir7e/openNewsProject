//
//  TabBarViewModel.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

struct TabBarViewModel {
    let type: TabBarItemType
    let tabBarItem: UITabBarItem
}

enum TabBarItemType: Int {
    case emailed
    case shared
    case viewed
    case favorites
}

