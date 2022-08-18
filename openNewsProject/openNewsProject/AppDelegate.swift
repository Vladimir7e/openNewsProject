//
//  AppDelegate.swift
//  openNewsProject
//
//  Created by Developer on 06.05.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var flowCoordinator: IFlowCoordinator?
    private let actionService: ActionService = ActionService.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        flowCoordinator = FlowCoordinator(window: window)
        flowCoordinator?.start()

        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem,
      completionHandler: (Bool) -> Void) {
        UIApplication.shared.shortcutItems = [shortcutItem]

        actionService.action = Action(shortcutItem: shortcutItem)
        completionHandler(true)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        flowCoordinator?.performQuickActionsForHomeScreen(action: actionService.action)
        actionService.action = nil
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "openNewsProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
