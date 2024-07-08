//
//  extensions.swift
//  project-z
//
//  Created by Inyene Etoedia on 06/06/2024.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

extension ShapeStyle where Self == Color {
    static var greyX: Color {
        return Color("grey")
    }
    
    
    static var passportText: Color {
        return Color(hex: "F9DCB2")
    }
    static var yellowCard: Color {
        return Color(hex: "FFDC08")
    }
    static var lightYellow: Color {
        return Color(hex: "AD7F18")
    }
    static var seasonViewBg: Color {
        return Color(hex: "7A8696")
    }
    static var deepGray: Color {
        return Color(hex: "2C2C2C")
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.white)
    }
}

extension String {
    func truncate(_ length: Int, trailing: String = "…") -> String {
        (self.count > length) ? self.prefix(max(0, length - trailing.count)) + trailing : self
    }
}


enum CustomFontStyle: String {
    case regular = "Matter-Regular"
    case bold = "Matter-Bold"
    case medium = "Matter-Medium"
    case semiBold = "Matter-SemiBold"
    case light = "Matter-Light"
}

extension Font {
    static func custom(_ style: CustomFontStyle, size: CGFloat) -> Font {
        return Font.custom(style.rawValue, size: size)
    }
}
