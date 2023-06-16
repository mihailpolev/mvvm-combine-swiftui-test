//
//  Animal+Types.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  enum Types: String {
    case dog           = "Dog"
    case cat           = "Cat"
    case rabbit        = "Rabbit"
    case smallAndFurry = "Small & Furry"
    case horse         = "Horse"
    case bird          = "Bird"
    case other         = "Scales, Fins & Other"
    case barnyard      = "Barnyard"
  }
}

// MARK: Codable

extension Animal.Types: Codable {}
