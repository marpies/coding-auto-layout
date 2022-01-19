//
//  AlertViewController.swift
//  CustomAlert
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class AlertViewController: UIViewController, AlertViewDelegate {
    
    var viewModel: Alert.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
        
        guard let viewModel = self.viewModel else {
            fatalError("Unexpected application state.")
        }
        
        let view = AlertView()
        view.setContent(viewModel: viewModel)
        view.delegate = self
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: AlertView.maxWidth)
        ])
    }
    
    func alertButtonDidTap(at index: Int) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
