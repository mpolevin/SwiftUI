//
//  RandomAccessCollection+isLast.swift
//  SwiftUIApp
//
//  Created by Mikhail Polevin on 11.04.2020.
//  Copyright © 2020 Mikhail Polevin. All rights reserved.
//

extension String: Identifiable {
    public var id: String {
        self
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    public func isLast(_ item: Element)->Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) })  else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
}

