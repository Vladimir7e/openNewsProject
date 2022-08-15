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
        if let shortcutItem = actionService.action,
           let topViewContoller: UIViewController = UIApplication.topViewController() {
           
            switch shortcutItem {
            case .emailed:
                topViewContoller.tabBarController?.selectedIndex = 0
            case .shared:
                topViewContoller.tabBarController?.selectedIndex = 1
            case .viewed:
                topViewContoller.tabBarController?.selectedIndex = 2
            case .favorites:
                topViewContoller.tabBarController?.selectedIndex = 3
            }
            
            actionService.action = nil
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "openNewsProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
