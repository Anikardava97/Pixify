//
//  OnboardingViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - Properties
    private let onboardingBackgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .onBoardingBackground)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeTextStackView, tryItNowButton])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var welcomeTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, appBenefitLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Pixify"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .customTextColor
        return label
    }()
    
    private let appBenefitLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore stunning photos and get inspired daily"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .customTextColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tryItNowButton: MainButtonComponent = {
        let button = MainButtonComponent(text: "Try it now")
        button.addTarget(self, action: #selector(tryButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        animateImageScroll()
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
        view.addSubview(onboardingBackgroundImageView)
        view.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingBackgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func animateImageScroll() {
        UIView.animate(withDuration: 1.5, delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
            self.onboardingBackgroundImageView.transform = CGAffineTransform(
                translationX: 0,
                y: -self.view.frame.height / 2.0)
        }, completion: nil)
    }
    
    // MARK: - Actions
    @objc func tryButtonDidTap() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
