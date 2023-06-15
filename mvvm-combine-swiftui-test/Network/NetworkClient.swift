//
//  NetworkClient.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation
import Alamofire

protocol NetworkClientType {
  func getAnimals() async throws -> [Animal]
}

class NetworkClient: NetworkClientType {
  var authService: AuthService = AuthService()
  
  func getAnimals() async throws -> [Animal] {
    if authService.isTokenExpired() {
      try await authService.auth()
    }
    
    guard let token = Keychain.load(key: AuthService.keychainKey) else {
      return []
    }
    
    let data = try await NetworkClient.request(url: "/animals", method: .get, token: token)
    
    let response = try JSONDecoder().decode(AnimalResponse.self, from: data)
    
    return response.animals
  }
  

//    NetworkClient.request(url: url, parameters: parameters) { data, response, error in
//      if data == nil || response == nil || error != nil {
//        onCompletion(.failure(.clientError))
//        return
//      }
//
//      var statusCode = 500
//      if let response = response as? HTTPURLResponse {
//        statusCode = response.statusCode
//      }
//
//      do {
//        switch statusCode {
//        case 404:
//          // let response = try JSONDecoderWrapper().decode(ErrorResponse.self, from: data!)
//          onCompletion(.failure(.serverError(message: response.error.message)))
//        case 200:
//            // let user = try JSONDecoderWrapper().decode(User.self, from: data!)
//            // onCompletion(.success(user))
//          onCompletion(.failure(.clientError))
//        default:
//          onCompletion(.failure(.serverErrorOther))
//        }
//      } catch {
//        onCompletion(.failure(.clientError))
//      }
//    }

}

extension NetworkClient {
  class func request(url: String, method: HTTPMethod, token: String) async throws -> Data {
    try await withUnsafeThrowingContinuation { completion in
      let headers: HTTPHeaders = [.authorization(bearerToken: token)]
      
      AF.request(Config.API_URL.rawValue + url, method: method, headers: headers)
        .validate()
        .responseData { response in
          if let data = response.data {
            completion.resume(returning: data)
            return
          }
          if let err = response.error {
            completion.resume(throwing: err)
            return
          }
          fatalError("should not get here")
        }
    }
  }
}
