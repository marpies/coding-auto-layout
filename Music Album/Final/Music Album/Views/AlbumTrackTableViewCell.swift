//
//  AlbumTrackTableViewCell.swift
//  Music Album
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class AlbumTrackTableViewCell: UITableViewCell {
    
    private let contentStack = UIStackView()
    private let orderLabel = UILabel()
    private let titleLabel = UILabel()
    private let button = UIButton(type: .system)
    private var lengthLabel: UILabel?
    
    private var activeConstraints: [NSLayoutConstraint] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.horizontalSizeClass != self.traitCollection.horizontalSizeClass {
            self.updateView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let isRegular: Bool = self.traitCollection.horizontalSizeClass == .regular
        
        if isRegular {
            self.button.tintColor = self.tintColor
        }
    }
    
    func update(viewModel: Album.Track.ViewModel) {
        self.titleLabel.text = viewModel.title
        self.orderLabel.text = viewModel.order
        self.lengthLabel?.text = viewModel.length
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.selectionStyle = .none
        
        self.contentStack.axis = .horizontal
        self.contentStack.alignment = .center
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            self.contentStack.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.contentStack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.contentStack.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.contentStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.orderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.orderLabel.textColor = .secondaryLabel
        self.orderLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.orderLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.contentStack.addArrangedSubview(self.orderLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.titleLabel.textColor = .label
        self.titleLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStack.addArrangedSubview(self.titleLabel)
        
        // Button
        self.button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.contentStack.addArrangedSubview(self.button)
        
        self.updateView()
    }
    
    private func updateView() {
        NSLayoutConstraint.deactivate(self.activeConstraints)
        self.activeConstraints.removeAll()
        
        let isRegular: Bool = self.traitCollection.horizontalSizeClass == .regular
        
        // Spacing for the content stack
        self.contentStack.spacing = isRegular ? 16 : 8
        
        // Min width for the order label
        let minWidth: CGFloat = self.orderLabel.getMinWidth(forText: "00")
        
        self.activeConstraints.append(
            self.orderLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth)
        )
        
        // Configure the button and length label for regular width
        if isRegular {
            self.button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            self.button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            
            self.lengthLabel = UILabel()
            self.lengthLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            self.lengthLabel?.textColor = .secondaryLabel
            self.lengthLabel?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            self.contentStack.addArrangedSubview(self.lengthLabel!)
            
            // Min width for the length label
            let minWidth: CGFloat = self.lengthLabel!.getMinWidth(forText: "00:00")
            
            self.activeConstraints.append(
                self.lengthLabel!.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth)
            )
        } else {
            // Remove length label in case it exists
            self.lengthLabel?.removeFromSuperview()
            self.lengthLabel = nil
            
            // Update button
            self.button.setImage(UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            self.button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            self.button.tintColor = .label
        }
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }
    
}

fileprivate extension UILabel {
    
    func getMinWidth(forText text: String) -> CGFloat {
        let size: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: self.font as Any])
        return size.width
    }
    
}
