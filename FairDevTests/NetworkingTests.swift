//
//  NetworkingTests.swift
//  FairDevTests
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import XCTest
@testable import FairDev

class NetworkingTest: XCTestCase {
    func testAllMakesDataFormat() {
        let success: ([Make]) -> Void  = { makes in
            XCTAssertNotNil(makes.first, "Should be at least one make from sample data")
        }
        let failure: (String) -> Void = { message in
            XCTFail(message)
        }
        let sampleData = dataFromJsonFile(named: "AllMakes")
        APIManager.sharedInstance.makes(with: .all, success: success, failure: failure, sampleData: sampleData)
    }

    func testIncorrectAllMakesReturnsFailure() {
        let success: ([Make]) -> Void  = { _ in
            XCTFail("Should fail on incorrect data")
        }
        let failure: (String) -> Void = { _ in }
        let sampleData = dataFromJsonFile(named: "Incorrect")
        APIManager.sharedInstance.makes(with: .all, success: success, failure: failure, sampleData: sampleData)
    }

    private func dataFromJsonFile(named fileName: String) -> Data {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            XCTFail("No json with name: \(fileName)")
            return Data ()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            XCTFail(error.localizedDescription)
            return Data()
        }
    }
}
