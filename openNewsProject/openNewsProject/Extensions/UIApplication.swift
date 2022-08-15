//
//  UIApplication.swift
//  openNewsProject
//
//  Created by Developer on 09.08.2022.
//

import Foundation
import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)
        }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController: UINavigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController: UITabBarController = controller as? UITabBarController {
            if let selected: UIViewController = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented: UIViewController = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
    
        return controller
    }
}
