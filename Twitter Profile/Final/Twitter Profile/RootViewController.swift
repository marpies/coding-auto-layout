//
//  RootViewController.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController, UIScrollViewDelegate {
    
    private let profileView = TwitterProfileView()
    
    private let viewModel: TwitterProfile.ViewModel = SampleModel.profile
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.profileView.translatesAutoresizingMaskIntoConstraints = false
        self.profileView.update(viewModel: self.viewModel)
        self.view.addSubview(self.profileView)
        
        NSLayoutConstraint.activate([
            self.profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.profileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.profileView.updateConstraints(for: size)
    }

}

