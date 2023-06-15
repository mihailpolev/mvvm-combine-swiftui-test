//
//  AnimalContactAddress+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalContactAddress: Codable {

  // MARK: - Coding Keys
  
  private enum CodingKeys: CodingKey {
    case address1
    case address2
    case city
    case state
    case postcode
    case country
  }
  
  // MARK: - Decodable
  
  public init(from decoder: Decoder) throws {
    let container     = try decoder.container(keyedBy: CodingKeys.self)
    
    let address1       = try container.decode(String?.self, forKey: .address1)
    let address2       = try container.decode(String?.self, forKey: .address2)
    let city           = try container.decode(String?.self, forKey: .city)
    let state          = try container.decode(String?.self, forKey: .state)
    let postcode       = try container.decode(String?.self, forKey: .postcode)
    let country        = try container.decode(String?.self, forKey: .country)

    self.init(address1: address1, address2: address2, city: city, state: state, postcode: postcode, country: country)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.address1, forKey: .address1)
    try container.encode(self.address2, forKey: .address1)
    try container.encode(self.city, forKey: .city)
    try container.encode(self.state, forKey: .state)
    try container.encode(self.postcode, forKey: .postcode)
    try container.encode(self.country, forKey: .country)
  }
  
}
