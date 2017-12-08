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

    private var yearCoordinator: YearCoordinator?

    init(rootViewController: UIViewController, make: Make) {
        self.rootViewController = rootViewController
        self.make = make
    }

    func start() {
        guard let itemVC = ItemViewController.instantiateFromStoryboard() else { return }
        itemVC.items = make.models.map { $0.niceName }
        itemVC.delegate = self
        itemVC.title = make.niceName
        rootViewController.show(itemVC, sender: nil)
    }
}

extension ModelCoordinator: ItemViewControllerDelegate {
    func itemViewController(_ viewController: ItemViewController, didSelectItemAt index: Int) {
        let model = make.models[index]
        let yearCoordinator = YearCoordinator(rootViewController: viewController, make: make, model: model)
        yearCoordinator.start()
        self.yearCoordinator = yearCoordinator
    }

    func userDidReturn(from: ItemViewController) {
        delegate?.jobIsFinished(for: self)
    }
}

extension ModelCoordinator: YearCoordinatorDelegate {
    func jobIsFinished(for: YearCoordinator) {
        yearCoordinator = nil
    }
}
