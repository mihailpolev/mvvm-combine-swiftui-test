//
//  AnimalSize.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

public enum AnimalSize: String {
  case samll        = "Small"
  case medium       = "Medium"
  case large        = "Large"
  case extraLarge   = "Extra Large"
}

// MARK: Codable

extension AnimalSize: Codable {}
