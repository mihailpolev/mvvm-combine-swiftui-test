//
//  Animal+Size.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

public extension Animal {
  enum Size: String {
    case samll        = "Small"
    case medium       = "Medium"
    case large        = "Large"
    case extraLarge   = "Extra Large"
  }
}

// MARK: Codable

extension Animal.Size: Codable {}
