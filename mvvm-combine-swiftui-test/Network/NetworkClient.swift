//
//  NetworkClient.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation
import Alamofire

class NetworkClient {
  var authService: AuthService = AuthService()
  
  /// Load Animals data
  /// - Returns: Result<[Animal], ErrorResponse>
  func getAnimals() async throws -> Result<[Animal], ErrorResponse> {
    if self.authService.isTokenExpired() {
      try await self.authService.auth()
    }
    
    guard let token = Keychain.load(key: AuthService.keychainKey) else {
      return .failure(.serverError(message: "Access token invalid or expired"))
    }
    
    let result = try await NetworkClient.request(url: "/animals", method: .get, token: token)
    
    do {
      let data = try result.get()
      let response = try JSONDecoder().decode(AnimalResponse.self, from: data)
      
      return .success(response.animals)
    } catch {
      return .failure(.otherError)
    }
  }
}

extension NetworkClient {
  /// Send request method
  /// - Parameters:
  ///   - url: String
  ///   - method: HTTPMethod
  ///   - token: token
  /// - Returns: Result<Data, ErrorResponse>
  class func request(url: String, method: HTTPMethod, token: String) async throws -> Result<Data, ErrorResponse> {
    let headers: HTTPHeaders = [.authorization(bearerToken: token)]
    
    let response = await AF.request(Config.API_URL.rawValue + url, method: method, headers: headers)
      .validate()
      .serializingData().response
        
    var statusCode = 500

    if let response = response.response {
      statusCode = response.statusCode
    }
    
    do {
      switch statusCode {
      case 400:
        let result = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
        return .failure(.serverError(message: result.localizedDescription))
      case 401:
        let result = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
        return .failure(.serverError(message: result.localizedDescription))
      case 404:
        let result = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
        return .failure(.serverError(message: result.localizedDescription))
      case 500:
        let result = try JSONDecoder().decode(ErrorResponse.self, from: response.data!)
        return .failure(.serverError(message: result.localizedDescription))
      case 200:
        return .success(response.data ?? .empty)
      default:
        return .failure(.otherError)
      }
    } catch {
      return .failure(.otherError)
    }
  }
}
