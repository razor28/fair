//
//  GalleryCell.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit
import Kingfisher

final class GalleryCell: UITableViewCell {
    var imageLinks = [URL]() { didSet { reloadData () } }
    @IBOutlet var collectionView: UICollectionView!

    private func reloadData() {
        guard collectionView != nil else { return }
        collectionView.reloadData()
    }
}

extension GalleryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageLinks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return imageCell(for: indexPath)
    }

    private func imageCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell",
                                                            for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        cell.imageView.kf.cancelDownloadTask()
        cell.imageView.kf.setImage(with: imageLinks[indexPath.row], placeholder: UIImage(named: "Placeholder"))
        return cell
    }
}
