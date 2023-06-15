//
//  AnimalType.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public enum AnimalType: String {
  case dog           = "Dog"
  case cat           = "Cat"
  case rabbit        = "Rabbit"
  case smallAndFurry = "Small & Furry"
  case horse         = "Horse"
  case bird          = "Bird"
  case other         = "Scales, Fins & Othe"
  case barnyard      = "Barnyard"
}

// MARK: Codable

extension AnimalType: Codable {}
