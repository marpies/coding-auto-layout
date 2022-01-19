//
//  TwitterFollowersView.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class TwitterFollowersView: UIView {
    
    private let contentStack = UIStackView()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(followers: String, following: String) {
        for view in self.contentStack.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        self.addLabelsStack(title: "FOLLOWERS", value: followers)
        self.addLabelsStack(title: "FOLLOWING", value: following)
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 8
        
        self.contentStack.axis = .horizontal
        self.contentStack.distribution = .fillEqually
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentStack.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.contentStack.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            self.contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .systemBackground
        self.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.widthAnchor.constraint(equalToConstant: 2),
            border.topAnchor.constraint(equalTo: self.topAnchor),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func addLabelsStack(title: String, value: String) {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        self.contentStack.addArrangedSubview(stack)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title
        stack.addArrangedSubview(titleLabel)
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        valueLabel.textColor = .label
        valueLabel.text = value
        stack.addArrangedSubview(valueLabel)
    }

}
