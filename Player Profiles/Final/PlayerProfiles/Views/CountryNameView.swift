//
//  CountryNameView.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class CountryNameView: UIStackView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(image: UIImage?, name: String) {
        self.imageView.image = image
        self.titleLabel.text = name
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.axis = .horizontal
        self.spacing = 16
        
        self.imageView.contentMode = .scaleAspectFit
        self.addArrangedSubview(self.imageView)
        
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.titleLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        self.addArrangedSubview(self.titleLabel)
    }

}
