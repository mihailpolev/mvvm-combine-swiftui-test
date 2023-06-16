//
//  AnimalContactAddress.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public extension Animal {
  struct Address {
    public let address1: String?
    public let address2: String?
    public let city:     String?
    public let state:    String?
    public let postcode: String?
    public let country:  String?
  }
}

// MARK: Codable

extension Animal.Address: Codable {}
