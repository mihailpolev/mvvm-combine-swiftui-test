//
//  Animal+Breeds.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  struct Breeds {
    public let primary:   String?
    public let secondary: String?
    public let mixed:     Bool
    public let unknown:   Bool
  }
}

// MARK: Codable

extension Animal.Breeds: Codable {}
