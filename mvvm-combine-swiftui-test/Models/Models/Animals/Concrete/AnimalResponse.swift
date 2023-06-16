//
//  AnimalResponse.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public struct AnimalResponse {
  public let animals: [Animal]
  public let pagination: AnimalResponsePagination
}

// MARK: Codable

extension AnimalResponse: Codable {}
