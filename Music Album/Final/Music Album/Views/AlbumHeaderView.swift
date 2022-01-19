//
//  AlbumHeaderView.swift
//  Music Album
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class AlbumHeaderView: UIView {
    
    private let contentStackView = UIStackView()
    private let coverView = UIImageView()
    private let labelsStack = UIStackView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let genreLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let playButton = AlbumButton(type: .system)
    private let shuffleButton = AlbumButton(type: .system)
    private let buttonsStack = UIStackView()
    
    private var activeConstraints: [NSLayoutConstraint] = []
    
    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.horizontalSizeClass != self.traitCollection.horizontalSizeClass {
            // Rebuild view hierarchy
            for view in self.contentStackView.subviews {
                view.removeFromSuperview()
            }
            
            self.contentStackView.removeFromSuperview()
            self.activeConstraints.removeAll()
            
            // Setup views again
            if self.traitCollection.horizontalSizeClass == .regular {
                self.setupRegularView()
            } else {
                self.setupCompactView()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.artistLabel.textColor = self.tintColor
    }
    
    func update(viewModel: Album.Header.ViewModel) {
        self.coverView.image = viewModel.coverImage
        self.titleLabel.text = viewModel.title
        self.artistLabel.text = viewModel.artistName
        self.genreLabel.text = viewModel.genre
        self.descriptionLabel.text = viewModel.description
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        if self.traitCollection.horizontalSizeClass == .regular {
            self.setupRegularView()
        } else {
            self.setupCompactView()
        }
    }
    
    private func setupRegularView() {
        // Content stack view
        self.contentStackView.axis = .horizontal
        self.contentStackView.alignment = .bottom
        self.contentStackView.distribution = .fillEqually
        self.contentStackView.spacing = 30
        self.contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        self.contentStackView.isLayoutMarginsRelativeArrangement = true
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentStackView)
        
        // Cover image view
        self.coverView.translatesAutoresizingMaskIntoConstraints = false
        self.coverView.contentMode = .scaleToFill
        self.coverView.layer.cornerRadius = 4
        self.coverView.layer.masksToBounds = true
        self.coverView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.coverView)
        
        // Labels stack (for the buttons as well)
        self.labelsStack.axis = .vertical
        self.labelsStack.spacing = 8
        self.labelsStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.labelsStack)
        
        // Title label
        let font: UIFont = UIFont.preferredFont(forTextStyle: .title1)
        self.titleLabel.font = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textColor = .label
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.titleLabel)
        
        // Artist label
        self.artistLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        self.artistLabel.numberOfLines = 2
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.artistLabel)
        
        // Genre label
        self.genreLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.genreLabel.textColor = .secondaryLabel
        self.genreLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.genreLabel)
        self.labelsStack.setCustomSpacing(30, after: self.genreLabel)
        
        // Description label
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.descriptionLabel.textColor = .secondaryLabel
        self.descriptionLabel.numberOfLines = 3
        self.descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.descriptionLabel)
        self.labelsStack.setCustomSpacing(30, after: self.descriptionLabel)
        
        // Buttons stack
        self.buttonsStack.axis = .horizontal
        self.buttonsStack.distribution = .fillEqually
        self.buttonsStack.spacing = 16
        self.buttonsStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.buttonsStack)
        
        self.addButtons(to: self.buttonsStack)
        
        self.addRegularConstraints()
    }
    
    private func addRegularConstraints() {
        NSLayoutConstraint.deactivate(self.activeConstraints)
        self.activeConstraints.removeAll()
        
        // Content stack view
        self.activeConstraints.append(contentsOf: [
            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).withPriority(.defaultHigh),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).withPriority(.defaultHigh),
            self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor).withPriority(.defaultHigh),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).withPriority(.defaultHigh)
        ])
        
        // Cover image view
        self.activeConstraints.append(contentsOf: [
            self.coverView.heightAnchor.constraint(equalTo: self.coverView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }
    
    private func setupCompactView() {
        // Content stack view
        self.contentStackView.axis = .vertical
        self.contentStackView.alignment = .center
        self.contentStackView.distribution = .fill
        self.contentStackView.spacing = 16
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        self.contentStackView.isLayoutMarginsRelativeArrangement = true
        self.addSubview(self.contentStackView)
        
        // Cover image view
        self.coverView.translatesAutoresizingMaskIntoConstraints = false
        self.coverView.contentMode = .scaleToFill
        self.coverView.layer.cornerRadius = 8
        self.coverView.layer.masksToBounds = true
        self.coverView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.coverView)
        
        // Labels stack
        self.labelsStack.axis = .vertical
        self.labelsStack.spacing = 4
        self.labelsStack.translatesAutoresizingMaskIntoConstraints = false
        self.labelsStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.labelsStack)
        
        // Title label
        let font: UIFont = UIFont.preferredFont(forTextStyle: .title2)
        self.titleLabel.font = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: font.pointSize)
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textColor = .label
        self.titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.titleLabel)
        
        // Artist label
        self.artistLabel.textAlignment = .center
        self.artistLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.artistLabel.numberOfLines = 2
        self.artistLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.artistLabel)
        
        // Genre label
        self.genreLabel.textAlignment = .center
        self.genreLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.genreLabel.textColor = .secondaryLabel
        self.genreLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.labelsStack.addArrangedSubview(self.genreLabel)
        
        // Buttons stack
        self.buttonsStack.axis = .horizontal
        self.buttonsStack.distribution = .fillEqually
        self.buttonsStack.spacing = 20
        self.buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        self.buttonsStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.buttonsStack)
        
        self.addButtons(to: self.buttonsStack)
        
        // Description label
        self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.descriptionLabel.textColor = .secondaryLabel
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStackView.addArrangedSubview(self.descriptionLabel)
        
        self.addCompactConstraints()
    }
    
    private func addCompactConstraints() {
        NSLayoutConstraint.deactivate(self.activeConstraints)
        self.activeConstraints.removeAll()
        
        // Content stack view
        self.activeConstraints.append(contentsOf: [
            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).withPriority(.defaultHigh),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).withPriority(.defaultHigh),
            self.contentStackView.topAnchor.constraint(equalTo: self.topAnchor).withPriority(.defaultHigh),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).withPriority(.defaultHigh)
        ])
        
        // Cover image view
        self.activeConstraints.append(contentsOf: [
            self.coverView.widthAnchor.constraint(equalTo: self.contentStackView.widthAnchor, multiplier: 2.0 / 3.0),
            self.coverView.heightAnchor.constraint(equalTo: self.coverView.widthAnchor)
        ])
        
        // Labels stack
        self.activeConstraints.append(contentsOf: [
            self.labelsStack.widthAnchor.constraint(equalTo: self.contentStackView.layoutMarginsGuide.widthAnchor)
        ])
        
        // Buttons stack
        self.activeConstraints.append(contentsOf: [
            self.buttonsStack.widthAnchor.constraint(equalTo: self.contentStackView.layoutMarginsGuide.widthAnchor)
        ])
        
        // Description label
        self.activeConstraints.append(contentsOf: [
            self.descriptionLabel.widthAnchor.constraint(equalTo: self.contentStackView.layoutMarginsGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }
    
    private func addButtons(to stack: UIStackView) {
        self.playButton.setImage(self.getButtonImage(name: "play.fill"), for: .normal)
        self.playButton.setTitle("Play", for: .normal)
        stack.addArrangedSubview(self.playButton)
        
        self.shuffleButton.setImage(self.getButtonImage(name: "shuffle"), for: .normal)
        self.shuffleButton.setTitle("Shuffle", for: .normal)
        stack.addArrangedSubview(self.shuffleButton)
    }
    
    private func getButtonImage(name: String) -> UIImage? {
        let size: CGFloat = UIFont.preferredFont(forTextStyle: .caption1).pointSize
        let config = UIImage.SymbolConfiguration(pointSize: size, weight: .semibold)
        return UIImage(systemName: name, withConfiguration: config)
    }

}
