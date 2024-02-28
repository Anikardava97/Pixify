//
//  CustomTextField.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: - Properties
    private let paddingWidth: CGFloat = 44
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .customSecondaryColor
        return imageView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    // MARK: - Setup
    private func setupTextField() {
        textColor = .customSecondaryColor.withAlphaComponent(0.6)
        font = UIFont.systemFont(ofSize: 16)
        backgroundColor = .clear
        layer.borderColor = UIColor.customSecondaryColor.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingWidth, height: bounds.height))
        leftView = paddingView
        leftViewMode = .always
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        tintColor = .customSecondaryColor
    }
    
    // MARK: - Set Error State
    func setErrorState(_ isError: Bool, withMessage message: String? = nil) {
        layer.borderColor = isError ? UIColor.red.cgColor : UIColor.customSecondaryColor.cgColor
        if let message = message, isError {
            errorLabel.text = message
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    // MARK: - Configure
    func configure(placeholder: String?, keyboardType: UIKeyboardType, icon: UIImage?, isSecure: Bool) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customSecondaryColor.withAlphaComponent(0.6)]
        )
        self.keyboardType = keyboardType
        iconImageView.image = icon
        isSecureTextEntry = isSecure
    }
}
