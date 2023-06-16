//
//  Color+Default.swift
//  mvvm-combine-swiftui-test
//
//  Created by Михаил Полев on 15.06.2023.
//

import SwiftUI

extension Color {
  public enum Custom: String, ColorCategory {
    case background = "Background"
    case text       = "Text"
    case detailBackground = "DetailBackground"
    case listCardBackground = "ListCardBackground"
    case listImagePlaceholder = "ListImagePlaceholder"
    case detailInfoBackground = "DetailInfoBackground"
    case maleColor = "MaleColor"
    case femaleColor = "FamaleColor"
    case infoGray = "InfoGray"
    case buttonBackground = "ButtonBackground"

    var name: String { return "\(self.rawValue)" }
  }
}

// MARK: - Color Extensions

public extension Color {
  static func custom(_ color: Custom) -> Color {
    return Color(color)
  }
}

public extension UIColor {
  static func custom(_ color: Color.Custom) -> UIColor {
    return UIColor(color)
  }
}

// MARK: - Preview

struct Color_Custom_Preview: PreviewProvider {
  static var previews: some View {
    Group {
      colors.preferredColorScheme(.light)
        .border(.black, width: 1.0)
    }
    Group {
      colors.preferredColorScheme(.dark)
        .border(.white, width: 1.0)
    }
  }
  
  static var colors: some View {
    VStack(spacing: 8.0) {
      Color.custom(.background).frame(width: 180.0, height: 90.0)
    }
  }
}
