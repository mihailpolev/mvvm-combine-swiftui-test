//
//  mvvm_combine_swiftui_testApp.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 14.06.2023.
//

import SwiftUI

@main
struct mvvm_combine_swiftui_testApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      AnimalsListView()
    }
  }
}
