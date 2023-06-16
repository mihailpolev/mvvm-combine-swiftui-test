//
//  ErrorResponse.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

enum ErrorResponse: Error {
  case serverError(message: String)
  case otherError
}

// MARK: Codable

extension ErrorResponse: Codable {}
