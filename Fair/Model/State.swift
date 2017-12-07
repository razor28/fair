//
//  State.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import UIKit

enum State: String, Iteratable {
    case all
    case new
    case used
    case future

    var tabBarItemTitle: String {
        switch self {
        case .all:
            return "Tab-Bar-Item-Title-All".localized
        case .new:
            return "Tab-Bar-Item-Title-New".localized
        case .used:
            return "Tab-Bar-Item-Title-Used".localized
        case .future:
            return "Tab-Bar-Item-Title-Future".localized
        }
    }

    var tabBarItemImage: UIImage? {
        switch self {
        case .all:
            return UIImage(named: ImageResource.tabBarItemAll.rawValue)
        case .new:
            return UIImage(named: ImageResource.tabBarItemNew.rawValue)
        case .used:
            return UIImage(named: ImageResource.tabBarItemUsed.rawValue)
        case .future:
            return UIImage(named: ImageResource.tabBarItemFuture.rawValue)
        }
    }

    var tabBarItemSelectedImage: UIImage? {
        switch self {
        case .all:
            return UIImage(named: ImageResource.tabBarItemAllSelected.rawValue)
        case .new:
            return UIImage(named: ImageResource.tabBarItemNewSelected.rawValue)
        case .used:
            return UIImage(named: ImageResource.tabBarItemUsedSelected.rawValue)
        case .future:
            return UIImage(named: ImageResource.tabBarItemFutureSelected.rawValue)
        }
    }
}
