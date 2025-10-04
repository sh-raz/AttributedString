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
    
    init(text: NSMutableAttributedString = NSMutableAttributedString(string: "The only way to do great work is to love what you do. — Steve Jobs"),
         attributes: [Attribute] = [.bold(isActive: false), .color(isActive: false), .animation(isActive: false)]) {
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
            case .animation(let isActive):
                attributesDic[.customAnimation] = isActive
            }
            
        }
    return attributesDic
}

}
