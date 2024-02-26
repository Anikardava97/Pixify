//
//  MainButtonComponent.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class MainButtonComponent: UIButton {
    // MARK: - Init
    init(text: String) {
        super.init(frame: .zero)
        
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.white, for: .normal)
        self.backgroundColor = .customAccentColor
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        layer.cornerRadius = 24
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
