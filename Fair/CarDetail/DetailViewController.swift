//
//  DetailViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func userDidReturn(from: DetailViewController)
    func imageLinks(for: DetailViewController) -> [URL]
}

final class DetailViewController: UIViewController {
    weak var delegate: DetailViewControllerDelegate?
    @IBOutlet var tableView: UITableView!

    static func instantiateFromStoryboard() -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let identifier = String(describing: DetailViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? DetailViewController else { return nil }
        return controller
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        guard parent == nil else { return }
        delegate?.userDidReturn(from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        tableView.tableFooterView = UIView()
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell") as? GalleryCell else { return UITableViewCell() }
            guard let imageLinks = delegate?.imageLinks(for: self) else { return cell }
            cell.imageLinks = imageLinks
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.0
        default:
            return 44.0
        }
    }
}
