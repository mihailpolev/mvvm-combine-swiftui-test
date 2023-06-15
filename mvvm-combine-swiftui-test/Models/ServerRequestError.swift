//
//  ServerRequestError.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

enum ServerRequestError: Error {
  case serverError(message: String)
  case serverErrorOther
  case clientError
  case parsing(message: String?)
}
