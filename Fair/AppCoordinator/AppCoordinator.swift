//
//  AppCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let tabBarController: UITabBarController

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        var tabViewControllers = [UINavigationController]()
        for rawValue in State.rawValues() {
            guard
                let state = State(rawValue: rawValue),
                let makeViewController = MakeViewController.instantiateFromStoryboard()
            else { continue }
            setupTabItems(for: makeViewController, with: state)
            tabViewControllers.append(UINavigationController(rootViewController: makeViewController))
        }
        tabBarController.viewControllers = tabViewControllers
    }

    private func setupTabItems(for viewController: UIViewController, with state: State) {
        let title = state.tabBarItemTitle
        let image = state.tabBarItemImage
        let seledtedImage = state.tabBarItemSelectedImage
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: seledtedImage)
    }
}
