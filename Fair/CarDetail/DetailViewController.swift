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
    func overViewText(for: DetailViewController) -> String
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

    func reloadOverview() {
        let sectionToReload = 1
        let indexSet: IndexSet = [sectionToReload]
        tableView.reloadSections(indexSet, with: .automatic)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Images"
        case 1:
            return "Overview"
        case 2:
            return "Links"
        default:
            return ""
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
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
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell") as? OverviewCell else { return UITableViewCell() }
            guard let overViewText = delegate?.overViewText(for: self) else { return cell }
            cell.textView.text = overViewText
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
            return 100
        case 1:
            return 200
        default:
            return 44
        }
    }
}
