//
//  ReusableTextView.swift
//  AttributedStringTest
//
//  Created by shilani on 16/12/2024.
//

import UIKit

class ReusableTextView: UICollectionReusableView {
    static var elementKind: String { UICollectionView.elementKindSectionHeader}

    var attributedText: AttributedText = AttributedText(text: NSMutableAttributedString(string: ""), attributes: [])
    {
        didSet{
            updateUI()
        }
    }
    
    var textView = UITextView()
    var shadowView = UIView()
    
    
//Initializers-----------------------------------------------------------------------------------------------------------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


 //Finctions--------------------------------------------------------------------------------------------------------------------------------------------
    func prepareView() {
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 0.5
        shadowView.frame = textView.frame
        shadowView.bounds = textView.bounds
        shadowView.layer.masksToBounds = false
        
        textView.attributedText = NSMutableAttributedString(string:  "This is a test text.")
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.backgroundColor = UIColor(named: "TextViewBackground")?.cgColor
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 8)
        textView.layer.cornerRadius = 15
        
        addSubview(shadowView)
        shadowView.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 430)
        ])
        updateUI()
    }
    
    
    func updateUI(){
        let attributesDic = attributedText.attributedKey()
        let attributedString = attributedText.text//NSMutableAttributedString(string:  "This is a test text.")
        attributedString.addAttributes(attributesDic, range: NSRange(location: 0, length: attributedString.length) )
        textView.attributedText = attributedString
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.layoutIfNeeded()
        }
    }

}
