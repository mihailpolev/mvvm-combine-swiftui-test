//
//  AnimalPhoto+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalPhoto: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    case small
    case medium
    case large
    case full
  }

  // MARK: - Decodable
    
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let small: URL?             = try container.decode(URL?.self, forKey: .small)
    let medium: URL?            = try container.decode(URL?.self, forKey: .medium)
    let large: URL?             = try container.decode(URL?.self, forKey: .large)
    let full: URL?              = try container.decode(URL?.self, forKey: .full)

    self.init(small: small, medium: medium, large: large, full: full)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.small, forKey: .small)
    try container.encode(self.medium, forKey: .medium)
    try container.encode(self.large, forKey: .large)
    try container.encode(self.full, forKey: .full)
  }

}

