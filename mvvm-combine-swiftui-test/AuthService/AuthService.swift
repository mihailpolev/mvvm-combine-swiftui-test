//
//  AuthService.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation
import Alamofire

enum AuthResult {
  case success
  case failure
}

class AuthService: ObservableObject {
  static let keychainKey = "ACCESS-TOKEN"
  static let expiredKey  = "ACCESS-TOKEN-EXPIRED"

  init() {}
  
  /// Bearer token
  var token: String? {
    get {
      Keychain.load(key: AuthService.keychainKey)
    }
    set {
      if let newToken = newValue {
        Keychain.save(key: AuthService.keychainKey, data: newToken)
      } else {
        Keychain.delete(key: AuthService.keychainKey)
      }
    }
  }
  
  /// Token exprired date
  var exprired: Date? {
    get {
      UserDefaults.standard.object(forKey: AuthService.expiredKey) as? Date
    }
    set {
      if let newDate = newValue {
        UserDefaults.standard.set(newDate, forKey: AuthService.expiredKey)
      } else {
        UserDefaults.standard.set(nil, forKey: AuthService.expiredKey)
      }
    }
  }
  
  /// Get token request
  func auth() async throws {
    let auth: AuthParameters = AuthParameters(grant_type: "client_credentials",
                                              client_id: Config.CLIENT_ID.rawValue,
                                              client_secret: Config.CLIENT_SECRET.rawValue)
    
    let result = try await AF.request(Config.API_URL.rawValue + "/oauth2/token", method: .post, parameters: auth)
      .validate()
      .serializingDecodable(Auth.self).value
    
    self.token = result.access_token
    self.exprired = result.expired
  }
  
  /// Delete token
  func logout() {
    token = nil
  }
  
  /// Check token 
  func isTokenExpired() -> Bool {
    guard let exprired = self.exprired else {
      return true
    }
    return Date() > exprired
  }
}
