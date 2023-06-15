//
//  AnimalResponse+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalResponse: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    case animals = "animals"
    case pagination = "pagination"
  }

  // MARK: - Decodable
    
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let animals: [Animal]                    = try container.decode([Animal].self, forKey: .animals)
    let pagination: AnimalResponsePagination = try container.decode(AnimalResponsePagination.self, forKey: .pagination)

    self.init(animals: animals, pagination: pagination)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.animals, forKey: .animals)
    try container.encode(self.pagination, forKey: .pagination)
  }

}

