//
//  TitledValueView.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class TitledValueView: UIStackView {
    
    private let titleLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(viewModel: TitledValue.ViewModel) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.axis = .vertical
        self.spacing = 16
        self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        self.isLayoutMarginsRelativeArrangement = true
        
        // Background view
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .secondarySystemBackground
        self.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        // Border view
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = .separator
        self.addSubview(borderView)
        
        NSLayoutConstraint.activate([
            borderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            borderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            borderView.widthAnchor.constraint(equalTo: self.widthAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Title label
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.titleLabel.textAlignment = .center
        self.titleLabel.minimumScaleFactor = 0.5
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.addArrangedSubview(self.titleLabel)
        
        // Value label
        self.valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.valueLabel.textAlignment = .center
        self.valueLabel.minimumScaleFactor = 0.5
        self.valueLabel.adjustsFontSizeToFitWidth = true
        self.addArrangedSubview(self.valueLabel)
    }

}
