//
//  RootViewController.swift
//  SignUpScreen
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private var activeConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.signUpView)
        
        self.setupView(for: self.traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.horizontalSizeClass != self.traitCollection.horizontalSizeClass {
            self.setupView(for: self.traitCollection)
        }
    }
    
    private func setupView(for traitCollection: UITraitCollection) {
        NSLayoutConstraint.deactivate(self.activeConstraints)
        
        if traitCollection.horizontalSizeClass == .regular {
            self.activeConstraints = [
                self.signUpView.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
                self.signUpView.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
                self.signUpView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor)
            ]
        } else {
            self.activeConstraints = [
                self.signUpView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
                self.signUpView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
                self.signUpView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }

}

