//
//  AnimalResponsePagination.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public struct AnimalResponsePagination {
  public let count_per_page: Int
  public let total_count: Int
  public let current_page: Int
  public var total_pages: Int
}

// MARK: Codable

extension AnimalResponsePagination: Codable {}
