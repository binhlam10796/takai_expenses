//
//  UIColor_Extension.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count == 6 {
            hexSanitized = hexSanitized + "FF"
        }
        
        if hexSanitized.count == 8 {
            let scanner = Scanner(string: hexSanitized)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
        }
        return nil
    }
    
    func toCGColor() -> CGColor {
        return self.cgColor
    }
}
