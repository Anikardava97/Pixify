//
//  HomeViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Methods
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        setupBackground()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .customBackgroundColor
    }
    
    private func setupSubviews() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
           
        ])
    }
}
