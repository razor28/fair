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
}

final class DetailViewController: UIViewController {
    weak var delegate: DetailViewControllerDelegate?

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
    }
}
