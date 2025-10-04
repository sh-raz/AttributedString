//
//  ButtonContentView.swift
//  AttributedStringTest
//
//  Created by shilani on 14/12/2024.
//

import UIKit

class ButtonContentView: UIView, UIContentView {
    
//ConfigurationStruct-----------------------------------------------------------------------------------------------
    struct Configuration: UIContentConfiguration {
        var attribute: Attribute = .bold(isActive: false)
        var onChange: (Attribute) -> Void = { _ in }
        
        func makeContentView() -> UIView & UIContentView {
            return ButtonContentView(self)
        }
        
        func updated(for state: UIConfigurationState) -> ButtonContentView.Configuration {
            return self
        }
    }
 
    
//configuration Instanse--------------------------------------------------------------------------------------------------------------------------------------------------------
    var configuration: UIContentConfiguration {
        didSet{
            configure(configuration: configuration)
        }
    }
  
    
    
    var button = UIButton()
    
    init(_ configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)//UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didPressed(_:)), for: .touchUpInside)
        //button.layer.shadowColor = UIColor.gray.cgColor
        //button.layer.shadowOpacity = 4
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        button.setTitle(configuration.attribute.name, for: .normal)
        button.layer.borderWidth = 4
        
        switch configuration.attribute {
        case .bold(let isActive):
            configureButtonColor(isActive)
        case .color(let isActive):
            configureButtonColor(isActive)
        case .animation(isActive: let isActive):
            configureButtonColor(isActive)
        }
    }
    
    
    @objc func didPressed(_ sender: UIButton) {
        guard var configuration = configuration as? ButtonContentView.Configuration else { return }
        switch configuration.attribute {
        case .bold(let isActive):
            configuration.attribute = .bold(isActive: !isActive)
        case .color(let isActive):
            configuration.attribute = .color(isActive: !isActive)
        case .animation(isActive: let isActive):
            configuration.attribute = .animation(isActive: !isActive)
        }
        configuration.onChange(configuration.attribute)
    }
    
    
    func configureButtonColor(_ isActive: Bool){
        button.backgroundColor = isActive ? Color.activeButton.mainColor : Color.InActiveButton.mainColor
        button.layer.borderColor =  isActive ? Color.activeButton.borderColor : Color.InActiveButton.borderColor
    }
}




