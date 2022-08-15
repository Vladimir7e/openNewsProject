//
//  Action.swift
//  openNewsProject
//
//  Created by Developer on 08.08.2022.
//

import Foundation
import UIKit

enum ActionType: String {
    case emailed = "Emailed"
    case shared = "Shared"
    case viewed = "Viewed"
    case favorites = "Favorites"
}

enum Action: Equatable {
    case emailed
    case shared
    case viewed
    case favorites
  
  init?(shortcutItem: UIApplicationShortcutItem) {
    guard let type = ActionType(rawValue: shortcutItem.type) else {
      return nil
    }
    
    switch type {
    case .emailed:
      self = .emailed
    case .shared:
        self = .shared
    case .viewed:
        self = .viewed
    case .favorites:
        self = .favorites
    }
  }
}

class ActionService: ObservableObject {
    static let shared: ActionService = ActionService()
    var action: Action?
}
