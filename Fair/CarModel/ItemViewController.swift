//
//  ItemViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol ItemViewControllerDelegate: class {
    func itemViewController(_: ItemViewController, didSelectItemAt index: Int)
    func userDidReturn(from: ItemViewController)
}

final class ItemViewController: UIViewController {
    var items = [String]()
    weak var delegate: ItemViewControllerDelegate?

    static func instantiateFromStoryboard() -> ItemViewController? {
        let storyboard = UIStoryboard(name: "Make", bundle: nil)
        let identifier = String(describing: ItemViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ItemViewController else { return nil }
        return controller
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        guard parent == nil else { return }
        delegate?.userDidReturn(from: self)
    }
}

extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.itemViewController(self, didSelectItemAt: indexPath.row)
    }
}
