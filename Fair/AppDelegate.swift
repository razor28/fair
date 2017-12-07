//
//  AppDelegate.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/5/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()
        window?.rootViewController = tabBarController
        let coordinator = AppCoordinator(tabBarController: tabBarController)
        coordinator.start()
        appCoordinator = coordinator
        return true
    }
}
