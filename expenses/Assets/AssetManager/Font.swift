//
//  Font.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation

struct Font {
    enum FontName: String {
        case OutfitBlack            = "Outfit-Black"
        case OutfitBold             = "Outfit-Bold"
        case OutfitSemiBold         = "Outfit-SemiBold"
        case OutfitExtraBold        = "Outfit-ExtraBold"
        case OutfitLight            = "Outfit_Light"
        case OutfitExtraLight       = "Outfit_ExtraLight"
        case OutfitMedium           = "Outfit-Medium"
        case OutfitRegular          = "Outfit-Regular"
        case OutfitThin             = "Outfit-Thin"
        case RowdiesBold            = "Rowdies-Bold"
        case RowdiesLight           = "Rowdies-Light"
        case RowdiesRegular         = "Rowdies-Regular"
    }
    
    enum StandardSize: Double {
        case s1 = 1.0
        case s2 = 2.0
        case s3 = 3.0
        case s4 = 4.0
        case s5 = 5.0
        case s6 = 6.0
        case s7 = 7.0
        case s8 = 8.0
        case s9 = 9.0
        case s10 = 10.0
        case s11 = 11.0
        case s12 = 12.0
        case s13 = 13.0
        case s14 = 14.0
        case s15 = 15.0
        case s16 = 16.0
        case s17 = 17.0
        case s18 = 18.0
        case s19 = 19.0
        case s20 = 20.0
        case s21 = 21.0
        case s22 = 22.0
        case s23 = 23.0
        case s24 = 24.0
        case s25 = 25.0
        case s26 = 26.0
        case s27 = 27.0
        case s28 = 28.0
        case s29 = 29.0
        case s30 = 30.0
        case s40 = 40.0
        case s100 = 100.0
    }
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    var type: FontType
    var size: FontSize
    
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}


