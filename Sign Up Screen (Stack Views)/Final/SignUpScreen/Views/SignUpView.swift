//
//  SignUpView.swift
//  SignUpScreen
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class SignUpView: UIStackView {

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 16
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.text = "Sign Up"
        self.addArrangedSubview(titleLabel)
        
        let emailField = BoxedUITextField()
        emailField.placeholder = "Email"
        self.addArrangedSubview(emailField)
        self.setCustomSpacing(8, after: emailField)
        
        let passwordField = BoxedUITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        self.addArrangedSubview(passwordField)
        
        let termsStack = UIStackView()
        termsStack.axis = .horizontal
        termsStack.alignment = .center
        termsStack.spacing = 16
        self.addArrangedSubview(termsStack)
        
        let toggle = UISwitch()
        termsStack.addArrangedSubview(toggle)
        
        let termsLabel = UILabel()
        termsLabel.text = "I have read and agree to the terms and conditions"
        termsLabel.numberOfLines = 0
        termsLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        termsLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        termsStack.addArrangedSubview(termsLabel)
        self.setCustomSpacing(24, after: termsStack)
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        self.addArrangedSubview(button)
    }

}
