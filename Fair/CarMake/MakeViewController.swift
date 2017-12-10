//
//  MakeViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit
import Kingfisher
import StatefulViewController

final class MakeViewController: UIViewController, Reloadable, StatefulViewController {
    @IBOutlet var tableView: UITableView!

    weak var carDataSource: CarDataSource?
    weak var selectableDelegate: Selectable?
    var dataState: DataState = .loading { didSet { reloadData() } }

    private let cellIdentifier = String(describing: MakeCell.self)
    private var items = [Make]()

    static func instantiateFromStoryboard() -> MakeViewController? {
        let storyboard = UIStoryboard(name: "Make", bundle: nil)
        let identifier = String(describing: MakeViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? MakeViewController else { return nil }
        return controller
    }

    private func reloadData() {
        defer { tableView.reloadData() }
        switch dataState {
        case .loading:
            return
        case .error:
            endLoading(error: NSError(domain: "foo", code: -1, userInfo: nil))
            return
        default:
            guard let items = carDataSource?.makes() else { return }
            self.items = items
            endLoading(error: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPlaceholderViews()
        setupInitialViewState()
        startLoading()
    }

    private func setupTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
    }

    private func setupPlaceholderViews() {
        loadingView = LoadingView(frame: view.frame)
        emptyView = EmptyView(frame: view.frame)
        let failureView = ErrorView(frame: view.frame)
        failureView.tapGestureRecognizer.addTarget(self, action: #selector(refresh))
        errorView = failureView
    }

    @objc private func refresh() {
        dataState = .loading
        carDataSource?.refreshDataSource()
    }

    func hasContent() -> Bool {
        return !items.isEmpty
    }
}

extension MakeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MakeCell else { return UITableViewCell() }
        let make = items[indexPath.row]
        cell.makeLabel.text = make.niceName
        cell.makeImageView.kf.cancelDownloadTask()
        if let possibleImageURL = URL(string: "https://logo.clearbit.com/" + make.niceName + ".com") {
            cell.makeImageView.kf.setImage(with: possibleImageURL)
        }
        return cell
    }
}

extension MakeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let make = items[indexPath.row]
        selectableDelegate?.viewController(self, didSelectMake: make)
    }
}
