//
//  AnimalAge.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

public enum AnimalAge: String {
  case baby         = "Baby"
  case young        = "Young"
  case adult        = "Adult"
  case senior       = "Senior"
}

// MARK: Codable

extension AnimalAge: Codable {}
