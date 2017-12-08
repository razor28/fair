//
//  YearCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol YearCoordinatorDelegate: class {
    func jobIsFinished(for: YearCoordinator)
}

final class YearCoordinator {
    let rootViewController: UIViewController
    let make: Make
    let model: Model

    weak var delegate: YearCoordinatorDelegate?

    private var detailCoordinator: DetailCoordinator?

    init(rootViewController: UIViewController, make: Make, model: Model) {
        self.rootViewController = rootViewController
        self.make = make
        self.model = model
    }

    func start() {
        guard let itemVC = ItemViewController.instantiateFromStoryboard() else { return }
        itemVC.items = model.years.map { "\($0.year)" }
        itemVC.delegate = self
        itemVC.title = model.niceName
        rootViewController.show(itemVC, sender: nil)
    }
}

extension YearCoordinator: ItemViewControllerDelegate {
    func itemViewController(_ viewController: ItemViewController, didSelectItemAt index: Int) {
        let year = model.years[index]
        let detailCoordinator = DetailCoordinator(rootViewController: viewController, make: make, model: model, year: year)
        detailCoordinator.delegate = self
        detailCoordinator.start()
        self.detailCoordinator = detailCoordinator
    }

    func userDidReturn(from: ItemViewController) {
        delegate?.jobIsFinished(for: self)
    }
}

extension YearCoordinator: DetailCoordinatorDelegate {
    func jobIsFinished(for: DetailCoordinator) {
        self.detailCoordinator = nil
    }
}
