//
//  AlertView.swift
//  CustomAlert
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

protocol AlertViewDelegate: AnyObject {
    func alertButtonDidTap(at index: Int)
}

class AlertView: UIView {
    
    static let maxWidth: CGFloat = 270
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    weak var delegate: AlertViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.layer.borderColor = UIColor.separator.cgColor
    }
    
    func setContent(viewModel: Alert.ViewModel) {
        // Title label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = viewModel.title
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
        ])
        
        // Message label
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        messageLabel.textColor = .label
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = viewModel.message
        self.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
        
        // Buttons
        let buttonStack = UIStackView()
        buttonStack.spacing = 8
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStack)
        
        for (index, model) in viewModel.buttons.enumerated() {
            let button = self.getButton(viewModel: model, index: index)
            buttonStack.addArrangedSubview(button)
        }
        
        buttonStack.layoutIfNeeded()
        
        let maxWidth: CGFloat = AlertView.maxWidth - (self.layoutMargins.left + self.layoutMargins.right)
        let buttonsWidth: CGFloat = buttonStack.bounds.width
        
        if buttonsWidth > maxWidth {
            buttonStack.axis = .vertical
            buttonStack.alignment = .center
            buttonStack.reverseOrder()
        } else {
            buttonStack.axis = .horizontal
            buttonStack.distribution = .fillEqually
        }
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            buttonStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.separator.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.backgroundColor = UIColor.secondarySystemBackground
    }
    
    private func getButton(viewModel: Button.ViewModel, index: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.tag = index
        button.setTitle(viewModel.title, for: .normal)
        button.addTarget(self, action: #selector(self.buttonDidTap), for: .touchUpInside)
        
        switch viewModel.style {
        case .default:
            let font: UIFont = button.titleLabel!.font
            button.titleLabel?.font = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        case .destructive:
            button.titleLabel?.tintColor = .red
        case .regular:
            break
        }
        
        return button
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        self.delegate?.alertButtonDidTap(at: sender.tag)
    }
    
}

fileprivate extension UIStackView {
    
    /// Reverses the order of the arranged views.
    func reverseOrder() {
        let subviews = self.subviews
        for view in subviews {
            self.insertArrangedSubview(view, at: 0)
        }
    }
    
}
