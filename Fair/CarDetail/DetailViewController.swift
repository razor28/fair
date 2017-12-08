//
//  DetailViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit
import MapKit

protocol DetailViewControllerDelegate: class {
    func userDidReturn(from: DetailViewController)
    func imageLinks(for: DetailViewController) -> [URL]
    func overViewText(for: DetailViewController) -> String
    func articles(for: DetailViewController) -> [Article]
    func dealers(for: DetailViewController) -> [Dealer]
}

final class DetailViewController: UIViewController {
    weak var delegate: DetailViewControllerDelegate?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var mapView: MKMapView!

    private var articles = [Article]()

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
        let indexSet: IndexSet = [1]
        tableView.reloadSections(indexSet, with: .automatic)
    }

    func reloadArticles() {
        guard let updatedArticles = delegate?.articles(for: self) else { return }
        articles = updatedArticles
        let indexSet: IndexSet = [2]
        tableView.reloadSections(indexSet, with: .automatic)
    }

    func reloadDealers() {
        mapView.removeAnnotations(mapView.annotations)
        guard let dealers = delegate?.dealers(for: self) else { return }
        for dealer in dealers {
            let location = CLLocationCoordinate2D(latitude: dealer.address.latitude, longitude: dealer.address.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
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
            return articles.count
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
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
            let article = articles[indexPath.row]
            cell.textLabel?.text = article.title
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
            return 150
        default:
            return 44
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 2 else { return }
        let link = articles[indexPath.row].link
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
}

extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = false
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let placemark = MKPlacemark(coordinate: annotation.coordinate)
        let launchOptions = [ MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: [MKMapItem.forCurrentLocation(), MKMapItem(placemark: placemark)], launchOptions: launchOptions)
    }
}
