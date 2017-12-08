//
//  CarDetail.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol DetailCoordinatorDelegate: class {
    func jobIsFinished(for: DetailCoordinator)
}

final class DetailCoordinator {
    let rootViewController: UIViewController
    let make: Make
    let model: Model
    let year: Year

    weak var delegate: DetailCoordinatorDelegate?

    init(rootViewController: UIViewController, make: Make, model: Model, year: Year) {
        self.rootViewController = rootViewController
        self.make = make
        self.model = model
        self.year = year
    }

    func start() {
        guard let detailVC = DetailViewController.instantiateFromStoryboard() else { return }
        detailVC.delegate = self
        rootViewController.show(detailVC, sender: nil)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func userDidReturn(from: DetailViewController) {
        delegate?.jobIsFinished(for: self)
    }

    func imageLinks(for: DetailViewController) -> [URL] {
        let baseString = "https://a.tcimg.net/v/model_images/v1/" +
                         "\(year.year)" + "/" + make.niceName + "/" + model.niceName
        return [URL(string: baseString + "/all/190x97/side"),
                URL(string: baseString + "/all/190x97/f3q"),
                URL(string: baseString + "/all/360x185/side"),
                URL(string: baseString + "/all/360x185/f3q")].flatMap { $0 }
    }
}
