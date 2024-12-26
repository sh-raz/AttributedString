//
//  AttributedString+Color.swift
//  AttributedStringTest
//
//  Created by shilani on 23/12/2024.
//

import UIKit


enum Color {
    case activeButton
    case InActiveButton
    
    
    
    var mainColor: UIColor {
        switch self {
        case .activeButton:
            return UIColor(named: "activeColor") ?? .systemPink
        case .InActiveButton:
            return UIColor(named: "inactiveColor") ?? .systemPink
        }
    }
    var borderColor: CGColor{
        switch self {
        case .activeButton:
            return UIColor(named: "activeBorderColor")?.cgColor ?? CGColor(gray: 0.4, alpha: 1)
        case .InActiveButton:
            return UIColor(named: "inactiveBorderColor")?.cgColor ?? CGColor(gray: 0.4, alpha: 1)
        }
    }
    
    var accentColor: UIColor {
        switch self {
        case .activeButton:
            return .white
        case .InActiveButton:
            return .black
        }
    }
}

    
    
    

