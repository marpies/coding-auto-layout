//
//  RetweetedByView.swift
//  Twitter Timeline
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RetweetedByView: UIStackView {
    
private let iconView = UIImageView()
private let avatarView = UIImageView()
private let displayNameLabel = UILabel()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.avatarView.layer.cornerRadius = self.avatarView.bounds.width * 0.2
    }
    
    func update(viewModel: Tweet.User.ViewModel) {
        self.avatarView.image = viewModel.avatar
        self.displayNameLabel.text = viewModel.displayName
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.axis = .horizontal
        self.alignment = .center
        self.spacing = 4
        
        let config = UIImage.SymbolConfiguration(textStyle: .caption1)
        let icon = UIImage(systemName: "arrow.2.squarepath", withConfiguration: config)
        
        self.iconView.image = icon
        self.iconView.tintColor = .secondaryLabel
        self.iconView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addArrangedSubview(self.iconView)
        
        self.avatarView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.avatarView.layer.masksToBounds = true
        self.addArrangedSubview(self.avatarView)
        
        self.displayNameLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.displayNameLabel.textColor = .secondaryLabel
        self.displayNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.displayNameLabel.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
        self.addArrangedSubview(self.displayNameLabel)
        
        let avatarSize: CGFloat = self.displayNameLabel.font.pointSize * 1.5
        
        NSLayoutConstraint.activate([
            self.avatarView.heightAnchor.constraint(equalToConstant: avatarSize),
            self.avatarView.widthAnchor.constraint(equalToConstant: avatarSize)
        ])
    }

}
