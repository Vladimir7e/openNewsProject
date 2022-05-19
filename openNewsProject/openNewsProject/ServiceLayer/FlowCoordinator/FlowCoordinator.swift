//
//  FlowCoordinator.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol IFlowCoordinator {
    func start()
}

final class FlowCoordinator: IFlowCoordinator {

    // Dependencies
    private weak var window: UIWindow?
    private let tabBarAssembly: ITabBarAssembly

    // MARK: - Initialization

    init(
        window: UIWindow,
        tabBarAssembly: ITabBarAssembly = TabBarAssembly()
    ) {
        self.window = window
        self.tabBarAssembly = tabBarAssembly
    }

    // MARK: - IFlowCoordinator

    func start() {
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        goToTabBar()
    }

    // MARK: - Private
    private func goToTabBar() {
        switchTo(tabBarAssembly.assemble())
    }

    private func switchTo(_ viewController: UIViewController) {
        let snapShot: UIView? = window?.snapshotView(afterScreenUpdates: true)
        if let snapShot: UIView = snapShot {
            window?.addSubview(snapShot)
        }
        dismiss(viewController) { [weak self] in
            self?.window?.rootViewController = viewController
            if let snapShot: UIView = snapShot {
                self?.window?.bringSubviewToFront(snapShot)
                UIView.animate(withDuration: 0.3, animations: {
                    snapShot.layer.opacity = 0
                }, completion: { _ in
                    DispatchQueue.main.async {
                        snapShot.removeFromSuperview()
                    }
                })
            }
        }
    }

    private func dismiss(_ viewController: UIViewController, completion: @escaping () -> Void) {
        if viewController.presentedViewController != nil {
            self.dismiss(viewController, completion: {
                viewController.dismiss(animated: false, completion: {
                    completion()
                })
            })
        } else {
            completion()
        }
    }
}
