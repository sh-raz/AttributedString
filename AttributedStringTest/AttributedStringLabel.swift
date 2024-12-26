//
//  AttributedStringLabel.swift
//  AttributedStringTest
//
//  Created by shilani on 15/12/2024. I lOVE YOU SHE SHE
//

import UIKit

class AttributedStringLabel: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var attributedText: AttributedText
        
        func makeContentView() -> UIView & UIContentView {
            return AttributedStringLabel(self)
        }
        func updated(for state: UIConfigurationState) -> AttributedStringLabel.Configuration {
            return self
        }
    }
    
    
    var configuration: UIContentConfiguration {
        didSet{
           configure(configuration: configuration)
        }
    }
    var label = UILabel()
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        label.attributedText = NSMutableAttributedString(string: "This is a test text.")
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        let attributedString = NSMutableAttributedString(string:  "This is a test text.")
        attributedString.addAttributes(configuration.attributedText.attributedKey(), range: NSRange(location: 0, length: 19) )
        label.attributedText = attributedString
       
    }
}
