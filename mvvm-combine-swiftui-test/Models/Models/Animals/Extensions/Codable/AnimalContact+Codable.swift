//
//  AnimalContact+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation

extension AnimalContact: Codable {
  // MARK: - Coding Keys
  
  private enum CodingKeys: CodingKey {
    case email
    case phone
    case address
  }
  
  // MARK: - Decodable
  
  public init(from decoder: Decoder) throws {
    let container     = try decoder.container(keyedBy: CodingKeys.self)
    
    let email       = try container.decode(String?.self, forKey: .email)
    let phone       = try container.decode(String?.self, forKey: .phone)
    let address     = try container.decode(AnimalContactAddress.self, forKey: .address)

    self.init(email: email, phone: phone, address: address)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.email, forKey: .email)
    try container.encode(self.phone, forKey: .phone)
    try container.encode(self.address, forKey: .address)
  }
  
}
