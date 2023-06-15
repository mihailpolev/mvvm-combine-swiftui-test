//
//  AnimalResponsePagination.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

public final class AnimalResponsePagination {
  public let count_per_page: Int
  public let total_count: Int
  public let current_page: Int
  public var total_pages: Int

  public init(count_per_page: Int, total_count: Int, current_page: Int, total_pages: Int) {
    self.count_per_page = count_per_page
    self.total_count = total_count
    self.current_page = current_page
    self.total_pages = total_pages
  }
}

