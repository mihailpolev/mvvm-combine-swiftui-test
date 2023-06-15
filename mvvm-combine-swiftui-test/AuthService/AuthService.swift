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

  func auth() async throws {
    let auth: AuthParameters = AuthParameters(grant_type: "client_credentials",
                                              client_id: Config.CLIENT_ID.rawValue,
                                              client_secret: Config.CLIENT_SECRET.rawValue)
    
    AF.request(Config.API_URL.rawValue + "/oauth2/token", method: .post, parameters: auth)
      .validate()
      .responseDecodable(of: Auth.self) { (response) in
        guard let result = response.value else {
          return
        }
        self.token = result.access_token
        self.exprired = result.expired
      }
  }
  
  func logout() {
    token = nil
  }
  
  func isTokenExpired() -> Bool {
    guard let exprired = self.exprired else {
      return true
    }
    return Date() > exprired
  }
}
