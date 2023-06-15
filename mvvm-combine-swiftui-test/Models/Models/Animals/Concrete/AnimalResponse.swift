//
//  AnimalResponse.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public final class AnimalResponse {
  public let animals: [Animal]
  public let pagination: AnimalResponsePagination

  public init(animals: [Animal], pagination: AnimalResponsePagination) {
    self.animals = animals
    self.pagination = pagination
  }
}
