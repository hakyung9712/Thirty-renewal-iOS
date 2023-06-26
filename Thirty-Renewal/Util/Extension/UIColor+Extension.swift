//
//  UIColor+Extension.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/27.
//

import UIKit

extension UIColor {
    static let gray50 = UIColor.init(named: "gray50")
    static let gray100 = UIColor.init(named: "gray100")
    static let gray200 = UIColor.init(named: "gray200")
    static let gray400 = UIColor.init(named: "gray400")
    static let gray500 = UIColor.init(named: "gray500")
    static let gray600 = UIColor.init(named: "gray600")
    static let gray800 = UIColor.init(named: "gray800")
    static let thirtyBlack = UIColor.init(named: "thirtyBlack")
    static let thirtyGreen = UIColor.init(named: "thirtyGreen")
    static let thirtyOrange = UIColor.init(named: "thirtyOrange")
    static let thirtyOrangeDark = UIColor.init(named: "thirtyOrangeDark")
    static let thirtyRed = UIColor.init(named: "thirtyRed")
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
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
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
