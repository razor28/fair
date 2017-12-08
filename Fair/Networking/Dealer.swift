//
//  Dealer.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

struct Dealer: Decodable {
    let dealerId: String
    let niceName: String
    let address: Address
}

struct Address: Decodable {
    let latitude: Double
    let longitude: Double
}
