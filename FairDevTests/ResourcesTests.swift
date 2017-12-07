//
//  FairDevTests.swift
//  FairDevTests
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import XCTest
@testable import FairDev

class FairDevTests: XCTestCase {
    func testImageResources() {
        for imageName in ImageResource.rawValues() {
            XCTAssertNotNil(UIImage(named: imageName), "Image named: " + imageName + " not found")
        }
    }
}
