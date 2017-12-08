//
//  Selectable.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/8/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

protocol Selectable: class {
    func viewController(_ viewController: UIViewController, didSelectMake: Make)
    func viewController(_ viewController: UIViewController, didSelecMake: Make, model: Model)
    func viewController(_ viewController: UIViewController, didSelecMake: Make, model: Model, year: Year)
}

extension Selectable {
    func viewController(_ viewController: UIViewController, didSelectMake: Make) { }
    func viewController(_ viewController: UIViewController, didSelecMake: Make, model: Model) { }
    func viewController(_ viewController: UIViewController, didSelecMake: Make, model: Model, year: Year) { }
}
