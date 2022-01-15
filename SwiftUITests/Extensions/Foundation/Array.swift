//
//  Array.swift
//  SwiftUITests
//
//  Created by YuriyFpc on 05.12.2021.
//

import Foundation

extension Array {
    func safeObjectAt(index: Int) -> Element? {
        if self.count > index {
            return self[index]
        } else {
            return nil
        }
    }
}
