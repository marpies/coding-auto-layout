//
//  RootViewController.swift
//  CustomAlert
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1: UIButton = UIButton(type: .system)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.setTitle("Show Alert 1", for: .normal)
        button1.addTarget(self, action: #selector(self.showRemoveAppAlert), for: .touchUpInside)
        self.view.addSubview(button1)
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button1.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        let button2: UIButton = UIButton(type: .system)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.setTitle("Show Alert 2", for: .normal)
        button2.addTarget(self, action: #selector(self.showPurchaseAlert), for: .touchUpInside)
        self.view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        self.view.backgroundColor = .systemBackground
    }
    
    @objc private func showRemoveAppAlert() {
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.viewModel = SampleModel.removeAppAlert
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func showPurchaseAlert() {
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.viewModel = SampleModel.purchaseAlert
        self.present(vc, animated: true, completion: nil)
    }


}

