//
//  ColorCategory.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import SwiftUI

protocol ColorCategory {
  var name: String { get }
}

extension Color {
  init(_ category: ColorCategory) {
    self.init(category.name, bundle: .main)
  }
}

extension UIColor {
  convenience init(_ category: ColorCategory) {
    self.init(named: category.name, in: .main, compatibleWith: nil)!
  }
}
