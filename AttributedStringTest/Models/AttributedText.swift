//
//  AttributedText.swift
//  AttributedStringTest
//
//  Created by shilani on 14/12/2024.
//

import UIKit

struct AttributedText{
    var text: NSMutableAttributedString //= NSMutableAttributedString(string: "This is test text inside AttributedText struct.")
    var attributes: [Attribute] //= [.bold(isActive: false), .color(isActive: false)]
    
    init(text: NSMutableAttributedString = NSMutableAttributedString(string: "This is test text inside AttributedText struct."),
         attributes: [Attribute] = [.bold(isActive: false), .color(isActive: false)]) {
        self.text = text
        self.attributes = attributes
    }
    
    
     func attributedKey() -> [NSAttributedString.Key: Any] {
        var attributesDic: [NSAttributedString.Key: Any] = [:]
        for attribute in attributes{
            switch attribute{
            case .bold(let isActive):
                if isActive{
                    let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
                    let boldFont = UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor, size: 0)
                    attributesDic[.font] = boldFont
                } else {
                    let normalFont = UIFont.preferredFont(forTextStyle: .body)
                
                    attributesDic[.font] = normalFont
                }
            case .color(let isActive):
                if isActive{
                    let textColor = UIColor.red 
                    attributesDic[.foregroundColor] = textColor
                }else {
                    let normalColor = UIColor.black
                    attributesDic[.foregroundColor] = normalColor
                }
            }
            
        }
    return attributesDic
}

//    mutating func updateProperty(name: String, active: Bool){
//        switch name {
//        case "bold": bold = active
//            
//        default:
//            <#code#>
//        }
//    }
}
