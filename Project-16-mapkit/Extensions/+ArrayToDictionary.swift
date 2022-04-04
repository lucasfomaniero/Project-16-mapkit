//
//  +ArrayToDictionary.swift
//  Project-16-mapkit
//
//  Created by Lucas Maniero on 03/04/22.
//

import Foundation

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
