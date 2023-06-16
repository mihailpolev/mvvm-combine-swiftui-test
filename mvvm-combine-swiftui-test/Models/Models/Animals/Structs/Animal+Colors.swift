//
//  Animal+Colors.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  struct Colors {
    public let primary:   String?
    public let secondary: String?
    public let tertiary:  String?
  }
}

// MARK: Codable

extension Animal.Colors: Codable {}
