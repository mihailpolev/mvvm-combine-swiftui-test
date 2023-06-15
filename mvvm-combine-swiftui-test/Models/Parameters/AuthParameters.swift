//
//  AuthParameters.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

struct AuthParameters: Encodable {
  let grant_type: String
  let client_id: String?
  let client_secret: String?
}
