//
//  ModelCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol ModelCoordinatorDelegate: class {
    func jobIsFinished(for: ModelCoordinator)
}

final class ModelCoordinator {
    let rootViewController: UIViewController
    let make: Make

    weak var delegate: ModelCoordinatorDelegate?

    init(rootViewController: UIViewController, make: Make) {
        self.rootViewController = rootViewController
        self.make = make
    }

    func start() {
        guard let itemVC = ItemViewController.instantiateFromStoryboard() else { return }
        itemVC.items = make.models.map { $0.niceName }
        itemVC.delegate = self
        rootViewController.show(itemVC, sender: nil)
    }
}

extension ModelCoordinator: ItemViewControllerDelegate {
    func itemViewController(_: ItemViewController, didSelectItemAt index: Int) {
        debugPrint("Model: \(make.models[index].niceName)")
    }

    func userDidReturn(from: ItemViewController) {
        delegate?.jobIsFinished(for: self)
    }
}
