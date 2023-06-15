//
//  Auth.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation

public final class Auth {
  public let token_type: String
  public let expired: Date
  public var access_token: String

  public init(token_type: String, expired: Date, access_token: String) {
    self.token_type = token_type
    self.expired = expired
    self.access_token = access_token
  }
}
