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

    private var overViewText: String?
    private var articles: [Article]?

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
        requestOverviewAndUpdate(detailVC)
        requestArticlesAndUpdate(detailVC)
    }

    private func requestOverviewAndUpdate(_ detailVC: DetailViewController) {
        let success: (String) -> Void  = { [weak detailVC, weak self] overview in
            guard
                let strongSelf = self,
                let strongVC = detailVC
             else { return }
            strongSelf.overViewText = overview
            strongVC.reloadOverview()
        }
        let failure: (String) -> Void = { [weak detailVC, weak self] message in
            guard
                let strongSelf = self,
                let strongVC = detailVC
                else { return }
            strongSelf.overViewText = message
            strongVC.reloadOverview()
        }
        APIManager.sharedInstance.overview(with: make.name, model: model.name, year: "\(year.year)", success: success, failure: failure)
    }

    private func requestArticlesAndUpdate(_ detailVC: DetailViewController) {
        let success: ([Article]) -> Void  = { [weak detailVC, weak self] articles in
            guard
                let strongSelf = self,
                let strongVC = detailVC
                else { return }
            strongSelf.articles = articles
            strongVC.reloadArticles()
        }
        let failure: (String) -> Void = { message in
           debugPrint(message)
        }
        APIManager.sharedInstance.articles(with: make.name, model: model.name, year: "\(year.year)", success: success, failure: failure)
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

    func overViewText(for: DetailViewController) -> String {
        guard let overViewText = overViewText else { return "" }
        return overViewText
    }

    func articles(for: DetailViewController) -> [Article] {
        guard let articles = articles else { return [] }
        return articles
    }
}
