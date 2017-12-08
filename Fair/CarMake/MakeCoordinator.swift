//
//  MakeCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

final class MakeCoordinator {
    let reloadableObject: Reloadable

    private let state: State
    private var items = [Make]()
    private var modelCoordinator: ModelCoordinator?

    init(reloadableObject: Reloadable, state: State) {
        self.reloadableObject = reloadableObject
        self.state = state
    }

    func start() {
        reloadableObject.carDataSource = self
        reloadableObject.selectableDelegate = self
        let success: ([Make]) -> Void  = { [weak self] makes in
            guard let strongSelf = self else { return }
            strongSelf.items = makes
            strongSelf.reloadableObject.reloadData()
        }
        let failure: (String) -> Void = { message in
            debugPrint("Error message: \(message)")
        }
        APIManager.sharedInstance.makes(with: state, success: success, failure: failure)
    }
}

extension MakeCoordinator: CarDataSource {
    func makes() -> [Make] {
        return items
    }
}

extension MakeCoordinator: Selectable {
    func viewController(_ viewController: UIViewController, didSelectMake make: Make) {
        let modelCoordinator = ModelCoordinator(rootViewController: viewController, make: make)
        modelCoordinator.start()
        modelCoordinator.delegate = self
        self.modelCoordinator = modelCoordinator
    }
}

extension MakeCoordinator: ModelCoordinatorDelegate {
    func jobIsFinished(for modelCoordinator: ModelCoordinator) {
        self.modelCoordinator = nil
    }
}
