//
//  MakeCoordinator.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

final class MakeCoordinator {
    let reloadableObject: Reloadable

    private let state: State
    private var items = [Make]()

    init(reloadableObject: Reloadable, state: State) {
        self.reloadableObject = reloadableObject
        self.state = state
    }

    func start() {
        reloadableObject.carDataSource = self
    }
}

extension MakeCoordinator: CarDataSource {
    func makes() -> [Make] {
        return items
    }
}
