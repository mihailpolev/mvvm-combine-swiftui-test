//
//  AnimalsListViewModel.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import Foundation
import Combine
import SwiftUI
import os

final class AnimalsListViewModel: ObservableObject {
  var networkClient: NetworkClient
  @Published var animals: [Animal] = []
  @Published var error: ErrorResponse?

  init(networkClient: NetworkClient) {
    self.networkClient = networkClient
    
    getAnimals()
  }
  
  /// Load animals list
  func getAnimals() {
    Task(priority: .userInitiated) { [weak self] in
      do {
        let result = try await self?.networkClient.getAnimals()
        
        do {
          let animals = try result?.get()
          await self?.update(animals: animals ?? [])
        } catch {
          await self?.update(error: .otherError)
        }
      } catch {
        Logger(subsystem: "sub", category: "AnimalsList").debug("\(error)")
      }
    }
  }
  
  /// Update animals state
  /// - Parameter animals: [Animal]
  @MainActor func update(animals: [Animal]) {
    self.animals = animals
  }
  
  /// Update error state
  /// - Parameter error: ErrorResponse?
  @MainActor func update(error: ErrorResponse?) {
    self.error = error
  }
  
  /// Toggle Color Scheme
  /// - Parameter colorScheme: ColorScheme
  func toggleColorScema(colorScheme: ColorScheme) {
    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = colorScheme == .light ? .dark : .light
  }
}

