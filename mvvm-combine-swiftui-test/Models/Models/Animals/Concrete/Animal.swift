//
//  Animal.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation

public final class Animal {
  public let id: Int
  public let organization_id: String
  public let url: URL?
  public let type: AnimalType
  public var species: String
  public var breeds: AnimalBreeds
  public var colors: AnimalColors
  public var age: AnimalAge
  public var gender: AnimalGender
  public var size: AnimalSize
  public var coat: String?
  public var name: String
  public var description: String?
  public var organization_animal_id: String?
  public var photos: [AnimalPhoto]
  public var primary_photo_cropped: AnimalPhoto?
  public var status: String
  public var status_changed_at: Date
  public var published_at: Date
  public var distance: Int?
  public var contact: AnimalContact

  public init(
    id: Int,
    organization_id: String,
    url: URL?,
    type: AnimalType,
    species: String,
    breeds: AnimalBreeds,
    colors: AnimalColors,
    age: AnimalAge,
    gender: AnimalGender,
    size: AnimalSize,
    coat: String?,
    name: String,
    description: String?,
    organization_animal_id: String?,
    photos: [AnimalPhoto],
    primary_photo_cropped: AnimalPhoto?,
    status: String,
    status_changed_at: Date,
    published_at: Date,
    distance: Int?,
    contact: AnimalContact
  ) {
    self.id = id
    self.organization_id = organization_id
    self.url = url
    self.type = type
    self.species = species
    self.breeds = breeds
    self.colors = colors
    self.age = age
    self.gender = gender
    self.size = size
    self.coat = coat
    self.name = name
    self.description = description
    self.organization_animal_id = organization_animal_id
    self.photos = photos
    self.primary_photo_cropped = primary_photo_cropped
    self.status = status
    self.status_changed_at = status_changed_at
    self.published_at = published_at
    self.distance = distance
    self.contact = contact
  }
}
