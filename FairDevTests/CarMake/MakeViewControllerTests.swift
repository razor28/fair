//
//  MakeViewController.swift
//  FairDevTests
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import XCTest
@testable import FairDev

class MakeViewControllerTests: XCTestCase {
    func testCanBeInitializedFromStoryboard() {
        XCTAssertNotNil(MakeViewController.instantiateFromStoryboard())
    }
}
