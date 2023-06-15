//
//  Auth+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//


import Foundation

extension Auth: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    case tokenType = "token_type"
    case expiresIn = "expires_in"
    case accessToken = "access_token"
    case expired = "expired"
  }

  // MARK: - Decodable
    
  public convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let tokenType: String   = try container.decode(String.self, forKey: .tokenType)
    let accessToken: String = try container.decode(String.self, forKey: .accessToken)
    let expiresIn: Int      = try container.decode(Int.self, forKey: .expiresIn)
    let expired: Date       = Date().addingTimeInterval(TimeInterval(expiresIn))

    self.init(token_type: tokenType, expired: expired, access_token: accessToken)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.token_type, forKey: .tokenType)
    try container.encode(self.expired, forKey: .expired)
    try container.encode(self.access_token, forKey: .accessToken)
  }

}
