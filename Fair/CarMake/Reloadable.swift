//
//  Reloadable.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

enum DataState {
    case loading
    case ready
    case error
}

protocol Reloadable: class {
    weak var carDataSource: CarDataSource? { get set }
    weak var selectableDelegate: Selectable? { get set }
    var dataState: DataState { get set }
}
