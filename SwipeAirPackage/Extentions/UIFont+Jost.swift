//
//  UIFont+Jost.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//
import UIKit

enum JostFontWeight: String {
    case thin = "Jost-Thin"
    case extraLight = "Jost-ExtraLight"
    case light = "Jost-Light"
    case regular = "Jost-Regular"
    case medium = "Jost-Medium"
    case semiBold = "Jost-SemiBold"
    case bold = "Jost-Bold"
    case extraBold = "Jost-ExtraBold"
    case black = "Jost-Black"
    case thinItalic = "Jost-ThinItalic"
    case extraLightItalic = "Jost-ExtraLightItalic"
    case lightItalic = "Jost-LightItalic"
    case italic = "Jost-Italic"
    case mediumItalic = "Jost-MediumItalic"
    case semiBoldItalic = "Jost-SemiBoldItalic"
    case boldItalic = "Jost-BoldItalic"
    case extraBoldItalic = "Jost-ExtraBoldItalic"
    case blackItalic = "Jost-BlackItalic"
}

extension UIFont {
    static func jost(_ weight: JostFontWeight, size: CGFloat, scaled: Bool = false) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        if scaled {
            return UIFontMetrics.default.scaledFont(for: font)
        } else {
            return font
        }
    }
}
