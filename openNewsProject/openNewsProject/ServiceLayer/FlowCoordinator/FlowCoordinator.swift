//
//  FlowCoordinator.swift
//  openNewsProject
//
//  Created by Developer on 18.05.2022.
//

import UIKit

protocol IFlowCoordinator {
    func start()
    func performQuickActionsForHomeScreen(action: Action?)
}

final class FlowCoordinator: IFlowCoordinator {
    // Dependencies
    private weak var window: UIWindow?
    private let tabBarAssembly: ITabBarAssembly
    private var vc: UIViewController?

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
    
    func performQuickActionsForHomeScreen(action: Action?) {
        if let shortcutItem: Action = action,
           let topViewContoller: UIViewController = UIApplication.topViewController() {
            let assembly: INewsAssembly = NewsAssembly()
            let backButton: UIButton = UIButton(type: .close)
//            backButton.setTitle(R.string.localizable.close(), for: .normal)
            backButton.addTarget(self, action: #selector(didTapBackButton(sender:)), for: .touchUpInside)
            
            switch shortcutItem {
            case .emailed:
                vc = assembly.assemble(newsType: .emailed)
            case .shared:
                vc = assembly.assemble(newsType: .shared)
            case .viewed:
                vc = assembly.assemble(newsType: .viewed)
            case .favorites:
                vc = assembly.assemble(newsType: .favorites)
            }
            
            guard let vc = vc else {
                return
            }
            
            let navController: UINavigationController = UINavigationController.init(rootViewController: vc)
            vc.navigationItem.leftBarButtonItem = .init(customView: backButton)
            navController.modalPresentationStyle = .overFullScreen
            topViewContoller.present(navController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapBackButton(sender: UIButton) {
        vc?.dismiss(animated: true, completion: nil)
    }
}
