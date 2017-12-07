//
//  AppCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

final class AppCoordinator: NSObject {
    private let tabBarController: UITabBarController
    private var childCoordinators = [MakeCoordinator]()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        tabBarController.delegate = self

        var tabViewControllers = [UINavigationController]()
        for rawValue in State.rawValues() {
            guard
                let state = State(rawValue: rawValue),
                let makeViewController = MakeViewController.instantiateFromStoryboard()
            else { continue }
            setup(makeViewController, with: state)
            tabViewControllers.append(UINavigationController(rootViewController: makeViewController))
            let makeCoordinator = MakeCoordinator(reloadableObject: makeViewController, state: state)
            childCoordinators.append(makeCoordinator)
        }
        tabBarController.viewControllers = tabViewControllers
        childCoordinators.first?.start()
    }

    private func setup(_ viewController: UIViewController, with state: State) {
        let title = state.tabBarItemTitle
        viewController.title = title
        let image = state.tabBarItemImage
        let seledtedImage = state.tabBarItemSelectedImage
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: seledtedImage)
    }
}

extension AppCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard
            let navigationController = viewController as? UINavigationController,
            let rootViewController = navigationController.viewControllers.first
        else { return }
        let affectedCoordinators = childCoordinators.filter { $0.reloadableObject === rootViewController }
        affectedCoordinators.forEach { coordinator in
            coordinator.start()
        }
    }
}
