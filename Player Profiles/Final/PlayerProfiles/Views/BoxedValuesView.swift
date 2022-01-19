//
//  BoxedValuesView.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class BoxedValuesView: UIView {
    
    private let contentStackView = UIStackView()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.layer.borderColor = UIColor.separator.cgColor
    }
    
    func update(viewModels: [TitledValue.ViewModel]) {
        for view in self.contentStackView.subviews {
            view.removeFromSuperview()
        }
        
        for (index, viewModel) in viewModels.enumerated() {
            let view = TitledValueView()
            view.update(viewModel: viewModel)
            self.contentStackView.addArrangedSubview(view)
            
            if index > 0 {
                let border = UIView()
                border.translatesAutoresizingMaskIntoConstraints = false
                border.backgroundColor = .separator
                self.contentStackView.addSubview(border)
                
                NSLayoutConstraint.activate([
                    border.centerXAnchor.constraint(equalTo: view.leadingAnchor),
                    border.widthAnchor.constraint(equalToConstant: 1),
                    border.topAnchor.constraint(equalTo: self.contentStackView.topAnchor),
                    border.bottomAnchor.constraint(equalTo: self.contentStackView.bottomAnchor)
                ])
            }
        }
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separator.cgColor
        self.layer.cornerRadius = 4
        
        self.contentStackView.axis = .horizontal
        self.contentStackView.distribution = .fillEqually
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentStackView)
        
        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
