//
//  Animal+Gender.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

public extension Animal {
  enum Gender: String {
    case male          = "Male"
    case female        = "Female"
  }
}

// MARK: Codable

extension Animal.Gender: Codable {}
