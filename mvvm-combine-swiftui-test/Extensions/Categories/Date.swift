//
//  Date.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 16.06.2023.
//

import Foundation

extension Date {
  func timeAgo() -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .short
    return formatter.localizedString(for: self, relativeTo: Date())
  }
}
