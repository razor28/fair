//
//  CarDataSource.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

protocol CarDataSource: class {
    func makes() -> [Make]
    func models(for: Make) -> [Model]
    func years(for: Model) -> [Year]
}

extension CarDataSource {
    func makes() -> [Make] {
        return [Make]()
    }

    func models(for: Make) -> [Model] {
        return [Model]()
    }

    func years(for: Model) -> [Year] {
        return [Year]()
    }
}
