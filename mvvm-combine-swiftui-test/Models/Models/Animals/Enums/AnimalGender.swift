//
//  AnimalGender.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

public enum AnimalGender: String {
  case male          = "Male"
  case female        = "Female"
}

// MARK: Codable

extension AnimalGender: Codable {}
