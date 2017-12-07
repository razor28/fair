//
//  MakeCellTests.swift
//  FairDevTests
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import XCTest
@testable import FairDev

class MakeCellTests: XCTestCase {
    var cell: MakeCell!

    override func setUp() {
        super.setUp()
        let viewController = UIViewController()
        _ = viewController.view

        let cellIdentifier = String(describing: MakeCell.self)
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        let tableView = UITableView()
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        viewController.view.addSubview(tableView)
        let dataSource = FakeTableViewDataSource()
        tableView.dataSource = dataSource
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: IndexPath(row: 0, section: 0)) as? MakeCell else {
            XCTFail("No " + cellIdentifier)
            return
        }
        self.cell = cell
    }

    func testHasMakeLabel() {
        XCTAssertNotNil(cell.makeLabel)
    }

    func testHasMakeImageView() {
        XCTAssertNotNil(cell.makeImageView)
    }
}

extension MakeCellTests {
    class FakeTableViewDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
