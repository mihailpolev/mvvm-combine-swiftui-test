//
//  Animal+Codable.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation

extension Animal: Codable {
  
  // MARK: - Coding Keys
  
  private enum CodingKeys: String, CodingKey {
    case id
    case organizationId = "organization_id"
    case url
    case type
    case species
    case breeds
    case colors
    case age
    case gender
    case size
    case coat
    case name
    case description
    case organizationAnimalId = "organization_animal_id"
    case photos
    case primaryPhotoCropped = "primary_photo_cropped"
    case status
    case statusChangedAt = "status_changed_at"
    case publishedAt = "published_at"
    case distance
    case contact
  }

  // MARK: - Decodable
    
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let id: Int                             = try container.decode(Int.self, forKey: .id)
    let organizationId: String              = try container.decode(String.self, forKey: .organizationId)
    let url: URL?                           = try container.decode(URL?.self, forKey: .url)
    let type: Animal.Types                  = try container.decode(Animal.Types.self, forKey: .type)
    let species: String                     = try container.decode(String.self, forKey: .species)
    let breeds: Animal.Breeds               = try container.decode(Animal.Breeds.self, forKey: .breeds)
    let colors: Animal.Colors               = try container.decode(Animal.Colors.self, forKey: .colors)
    let age: Animal.Age                     = try container.decode(Animal.Age.self, forKey: .age)
    let gender: Animal.Gender               = try container.decode(Animal.Gender.self, forKey: .gender)
    let size: Animal.Size                   = try container.decode(Animal.Size.self, forKey: .size)
    let coat: String?                       = try container.decode(String?.self, forKey: .coat)
    let name: String                        = try container.decode(String.self, forKey: .name)
    let description: String?                = try container.decode(String?.self, forKey: .description)
    let organizationAnimalId: String?       = try container.decode(String?.self, forKey: .organizationAnimalId)
    let photos: [Animal.Photo]              = try container.decode([Animal.Photo].self, forKey: .photos)
    let primaryPhotoCropped: Animal.Photo?  = try container.decode(Animal.Photo?.self, forKey: .primaryPhotoCropped)
    let status: String                      = try container.decode(String.self, forKey: .status)
    let statusChangedAt: String             = try container.decode(String.self, forKey: .statusChangedAt)
    let publishedAt: String                 = try container.decode(String.self, forKey: .publishedAt)
    let distance: Int?                      = try container.decode(Int?.self, forKey: .distance)
    let contact: Animal.Contact             = try container.decode(Animal.Contact.self, forKey: .contact)
    
    let dateFormatter = ISO8601DateFormatter()
    
    self.init(id: id,
              organization_id: organizationId,
              url: url,
              type: type,
              species: species,
              breeds: breeds,
              colors: colors,
              age: age,
              gender: gender,
              size: size,
              coat: coat,
              name: name,
              description: description,
              organization_animal_id: organizationAnimalId,
              photos: photos,
              primary_photo_cropped: primaryPhotoCropped,
              status: status,
              status_changed_at: dateFormatter.date(from: statusChangedAt) ?? Date(),
              published_at: dateFormatter.date(from: publishedAt) ?? Date(),
              distance: distance,
              contact: contact)
  }
  
  // MARK: - Encodable
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(self.id, forKey: .id)
    try container.encode(self.organization_id, forKey: .organizationId)
    try container.encode(self.url, forKey: .url)
    try container.encode(self.type, forKey: .type)
    try container.encode(self.species, forKey: .type)
    try container.encode(self.breeds, forKey: .breeds)
    try container.encode(self.colors, forKey: .colors)
    try container.encode(self.age, forKey: .age)
    try container.encode(self.gender, forKey: .gender)
    try container.encode(self.size, forKey: .size)
    try container.encode(self.coat, forKey: .coat)
    try container.encode(self.name, forKey: .name)
    try container.encode(self.description, forKey: .description)
    try container.encode(self.organization_animal_id, forKey: .organizationAnimalId)
    try container.encode(self.photos, forKey: .photos)
    try container.encode(self.primary_photo_cropped, forKey: .primaryPhotoCropped)
    try container.encode(self.status, forKey: .status)
    try container.encode(self.status_changed_at, forKey: .statusChangedAt)
    try container.encode(self.published_at, forKey: .publishedAt)
    try container.encode(self.distance, forKey: .distance)
    try container.encode(self.contact, forKey: .contact)

  }

}
