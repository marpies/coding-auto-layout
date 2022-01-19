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

class SignUpView: UIView {

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.text = "Sign Up"
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        let emailField = BoxedUITextField()
        emailField.placeholder = "Email"
        self.addSubview(emailField)
        
        NSLayoutConstraint.activate([
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
        
        let passwordField = BoxedUITextField()
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        self.addSubview(passwordField)
        
        NSLayoutConstraint.activate([
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 8)
        ])
        
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toggle)
        
        let termsLabel = UILabel()
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.text = "I have read and agree to the terms and conditions"
        termsLabel.numberOfLines = 0
        termsLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.addSubview(termsLabel)
        
        NSLayoutConstraint.activate([
            termsLabel.leadingAnchor.constraint(equalTo: toggle.trailingAnchor, constant: 16),
            termsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            termsLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            toggle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            toggle.centerYAnchor.constraint(equalTo: termsLabel.centerYAnchor)
        ])
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            button.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 24),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
