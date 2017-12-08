//
//  Model.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let id: String
    let name: String
    let niceName: String
    let years: [Year]
}
