//
//  Animal+Contact.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  struct Contact {
    public let email: String?
    public let phone: String?
    public let address: Animal.Address
  }
}

// MARK: Codable

extension Animal.Contact: Codable {}
