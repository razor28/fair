//
//  Iteratable.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/6/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation

/**
 Iterates thru enum options. Mostly used for testing resource availability
 
 - taken from:
 [Stackoverflow](https://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type)
 */

protocol Iteratable {}

extension RawRepresentable where Self: RawRepresentable {

    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

extension Iteratable where Self: RawRepresentable, Self: Hashable {
    static func hashValues() -> AnyIterator<Self> {
        return iterateEnum(self)
    }

    static func rawValues() -> [Self.RawValue] {
        return hashValues().map({$0.rawValue})
    }
}
