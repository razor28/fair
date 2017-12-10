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
    func refreshDataSource()
}

extension CarDataSource {
    func makes() -> [Make] {
        return [Make]()
    }

    func refreshDataSource() { }
}
