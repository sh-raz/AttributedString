//
//  Attribute.swift
//  AttributedStringTest
//
//  Created by shilani on 14/12/2024.
//

import UIKit

enum Attribute: Hashable {
    case bold(isActive: Bool)
    case color(isActive: Bool)
    
    var name: String{
        switch self{
        case .bold:
            return "Bold"
        case .color:
            return "Color"
        }
    }
    
//    var attributedKey: NSAttributedString.Key {
//        switch self{
//        case .bold:
//            return .font
//        case .color:
//            return .foregroundColor
//        }
//    }
    
//    var attributedValue: Any {
//        switch self{
//        case .bold(let isActive):
//            if isActive {
//                return UIFont.boldSystemFont(ofSize: 10)
//            }else{
//                return UIFont.systemFont(ofSize: 15)
//            }
//        case .color(let isActive):
//            if isActive {
//                return UIColor.red
//            }else{
//                return UIColor.gray
//            }
//        }
//    }
    
}

//
//extension [Attribute] {
//    func indexOfAttribute(attribute: Attribute) -> Self.Index?{
//        guard let index = firstIndex(where: { $0 == attribute } ) else {return nil}
//        return index
//    }
//}

//struct Attribute {
//
//
//    var name: String
//    var isActive: Bool
//
//    func AttributedKey() -> NSAttributedString.Key {
//
//    }
//
//    func attributedValue() -> Any {
//
//    }
//}



