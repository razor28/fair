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
    var makeViewController: MakeViewController!

    override func setUp() {
        super.setUp()
        guard let viewController = MakeViewController.instantiateFromStoryboard() else {
            XCTFail("Can't instanciate makeViewController from storyboard")
            return
        }
        _ = viewController.view
        makeViewController = viewController
    }

    func testCanBeInitializedFromStoryboard() { }

    func testHasTableView() {
        XCTAssertNotNil(makeViewController.tableView)
    }
}
