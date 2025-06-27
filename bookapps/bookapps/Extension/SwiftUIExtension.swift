//
//  SwiftUIExtension.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import SwiftUI

// MARK: Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b, a: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24 & 0xFF, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (1, 1, 1, 1)
        }

        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

// MARK: View Extension

struct HelveticaFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: size))
            .fontWeight(weight)
    }
}

extension View {
    func helveticaFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(HelveticaFontModifier(size: size, weight: weight))
    }
}


