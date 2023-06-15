//
//  AnimalsListViewModel.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation
import Combine
import SwiftUI

final class AnimalsListViewModel: ObservableObject {
  var networkClient: NetworkClientType
  @Published var animals: [Animal] = []

  init(networkClient: NetworkClientType) {
    self.networkClient = networkClient
    
    getAnimals()
  }
  
  func getAnimals() {
    Task { @MainActor [weak self] in
      do {
        let result = try await self?.networkClient.getAnimals()
        self?.animals = result ?? []
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func toggleColorScema(colorScheme: ColorScheme) {
    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = colorScheme == .light ? .dark : .light
  }
}

