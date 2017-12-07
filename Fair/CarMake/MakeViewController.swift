//
//  MakeViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

final class MakeViewController: UIViewController, Reloadable {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    var carDataSource: CarDataSource?

    private let cellIdentifier = String(describing: MakeCell.self)
    private var items = [Make]()

    static func instantiateFromStoryboard() -> MakeViewController? {
        let storyboard = UIStoryboard(name: "Make", bundle: nil)
        let identifier = String(describing: MakeViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? MakeViewController else { return nil }
        return controller
    }

    func reloadData() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}

extension MakeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MakeCell else { return UITableViewCell() }
//        let make = items[indexPath.row]
//        cell.makeLabel.text = make.niceName
        return cell
    }
}
