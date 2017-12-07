//
//  MakeViewController.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

final class MakeViewController: UIViewController {
    static func instantiateFromStoryboard() -> MakeViewController? {
        let storyboard = UIStoryboard(name: "Make", bundle: nil)
        let identifier = String(describing: MakeViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? MakeViewController else { return nil }
        return controller
    }
}
