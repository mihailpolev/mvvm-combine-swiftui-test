//
//  AnimalDetailViewModel.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import Foundation
import Combine

final class AnimalDetailViewModel: ObservableObject {
  @Published var animal: Animal?
  
  func update(animal: Animal) {
    self.animal = animal
  }
}
