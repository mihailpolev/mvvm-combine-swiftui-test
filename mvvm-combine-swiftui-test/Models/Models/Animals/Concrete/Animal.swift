//
//  Animal.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation

public struct Animal {
  public let id: Int
  public let organization_id: String
  public let url: URL?
  public let type: Animal.Types
  public var species: String
  public var breeds: Animal.Breeds
  public var colors: Animal.Colors
  public var age: Animal.Age
  public var gender: Animal.Gender
  public var size: Animal.Size
  public var coat: String?
  public var name: String
  public var description: String?
  public var organization_animal_id: String?
  public var photos: [Animal.Photo]
  public var primary_photo_cropped: Animal.Photo?
  public var status: String
  public var status_changed_at: Date
  public var published_at: Date
  public var distance: Int?
  public var contact: Animal.Contact
}
