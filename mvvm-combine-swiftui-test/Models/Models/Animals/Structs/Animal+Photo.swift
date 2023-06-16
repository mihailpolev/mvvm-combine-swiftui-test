//
//  AnimalPhoto.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  struct Photo {
    public let small: URL?
    public let medium: URL?
    public let large: URL?
    public let full: URL?
  }
}

// MARK: Codable

extension Animal.Photo: Codable {}
