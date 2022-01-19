//
//  RootViewController.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController {
    
    private var isInitialized: Bool = false
    
    private let contentStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.contentStackView.spacing = 16
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.contentStackView)
        
        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.contentStackView.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor)
        ])
        
        let player1View = PlayerProfileView()
        player1View.update(viewModel: SampleModel.player1)
        self.contentStackView.addArrangedSubview(player1View)

        let player2View = PlayerProfileView()
        player2View.update(viewModel: SampleModel.player2)
        self.contentStackView.addArrangedSubview(player2View)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !self.isInitialized {
            self.isInitialized = true
            
            self.setupView(for: self.view.bounds.size)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setupView(for: size)
    }
    
    private func setupView(for size: CGSize) {
        if size.width > 500 {
            self.contentStackView.axis = .horizontal
            self.contentStackView.distribution = .fillEqually
        } else {
            self.contentStackView.axis = .vertical
            self.contentStackView.distribution = .fill
        }
    }

}

