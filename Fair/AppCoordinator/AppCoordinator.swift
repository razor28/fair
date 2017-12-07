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
            guard let state = State(rawValue: rawValue) else { continue }
            let vc = viewController(with: state)
            let navigationController = UINavigationController(rootViewController: vc)
            tabViewControllers.append(navigationController)
        }
        tabBarController.viewControllers = tabViewControllers
    }

    private func viewController(with state: State) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.white
        let title = state.tabBarItemTitle
        let image = state.tabBarItemImage
        let seledtedImage = state.tabBarItemSelectedImage
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: seledtedImage)
        return viewController
    }
}
