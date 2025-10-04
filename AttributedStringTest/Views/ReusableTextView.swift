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
    var textLayer = TextLayer()
    
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
       
        var attributedString = attributedText.text
        attributedString.addAttributes(attributesDic, range: NSRange(location: 0, length: attributedString.length) )
        textView.attributedText = attributedString
        
        if let animation = attributesDic[.customAnimation]  as? Bool , animation == true {
            attributedString = NSMutableAttributedString(string: "")
            textView.attributedText = attributedString
            self.configureAnimation(text: attributedText.text)
            self.addAnimation()
        }else{
            removeAnimation()
        }
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.layoutIfNeeded()
        }
    }
    
    
    
    
    
    func configureAnimation(text: NSMutableAttributedString){
//        var textLayer = TextLayer()
        textLayer.attributedString = text
        textView.layer.addSublayer(textLayer)
        
//        let layerWidth = text.size().width + 20
//        let layerHeight = text.size().height + 20
//
        let posX = textView.bounds.origin.x + 10.0
      let posY = textView.bounds.origin.y + 10.0

       // textLayer.frame = textView.bounds//CGRect(x: posX, y: posY, width: layerWidth, height: layerHeight)
        textLayer.frame = CGRect(x: posX, y: posY, width: textView.bounds.width, height: textView.bounds.height)
    }

    
    func addAnimation(){
          var beginTime = CACurrentMediaTime() + 0.1
          textLayer.segmentedTextLayers.forEach { layer in
              // To make each layer scaled to zero initially
              layer.removeAllAnimations()
              layer.transform = CATransform3DMakeScale(0, 0, 1.0)
              
              //apply animation to each layer seperately with a separate begin time, each animation will start after the prev ends
              let animation = CABasicAnimation(keyPath: "transform.scale")
              animation.beginTime = beginTime
              animation.fromValue = 0
              animation.toValue = 1
              animation.duration = 0.1
              animation.fillMode = .forwards
              animation.isRemovedOnCompletion = false
              layer.add(animation, forKey: UUID().uuidString)
              beginTime = beginTime + animation.duration
          }
      }
    
    func removeAnimation(){
        //attributedString = NSMutableAttributedString(string: "")
       // attributedText.text = NSMutableAttributedString(string: "")
          textLayer.segmentedTextLayers.forEach { layer in
              textLayer.attributedString = NSMutableAttributedString(string: "")
              layer.removeAllAnimations()
              layer.transform = CATransform3DMakeScale(0, 0, 1.0)
          }
      }
    
    
    
    

}
