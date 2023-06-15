//
//  AnimalColors+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalColors: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: CodingKey {
    case primary
    case secondary
    case tertiary
  }
  
  // MARK: - Decodable
  
  public init(from decoder: Decoder) throws {
    let container     = try decoder.container(keyedBy: CodingKeys.self)
    
    let primary        = try container.decode(String?.self, forKey: .primary)
    let secondary      = try container.decode(String?.self, forKey: .secondary)
    let tertiary       = try container.decode(String?.self, forKey: .tertiary)

    self.init(primary: primary, secondary: secondary, tertiary: tertiary)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.primary, forKey: .primary)
    try container.encode(self.secondary, forKey: .secondary)
    try container.encode(self.tertiary, forKey: .tertiary)
  }
  
}
