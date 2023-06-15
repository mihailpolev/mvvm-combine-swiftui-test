//
//  AnimalResponsePagination+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalResponsePagination: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    case countPerPage = "count_per_page"
    case totalCount = "total_count"
    case currentPage = "current_page"
    case totalPages = "total_pages"
  }

  // MARK: - Decodable
    
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let countPerPage: Int = try container.decode(Int.self, forKey: .countPerPage)
    let totalCount: Int   = try container.decode(Int.self, forKey: .totalCount)
    let currentPage: Int  = try container.decode(Int.self, forKey: .currentPage)
    let totalPages: Int   = try container.decode(Int.self, forKey: .totalPages)

    self.init(count_per_page: countPerPage, total_count: totalCount, current_page: currentPage, total_pages: totalPages)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.count_per_page, forKey: .countPerPage)
    try container.encode(self.total_count, forKey: .totalCount)
    try container.encode(self.current_page, forKey: .currentPage)
    try container.encode(self.total_pages, forKey: .totalPages)
  }

}
