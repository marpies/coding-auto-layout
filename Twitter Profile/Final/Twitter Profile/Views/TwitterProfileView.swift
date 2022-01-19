//
//  TwitterProfileView.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class TwitterProfileView: UIView {
    
    private let headerView = UIImageView(image: UIImage(named: "header"))
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let avatarView = UIImageView()
    private let displayNameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let bioLabel = UILabel()
    private let locationButton = UIButton(type: .system)
    private let urlButton = UIButton(type: .system)
    private let followersView = TwitterFollowersView()
    private let tweetsStack = TweetsStackView()
    
    private let headerMinHeight: CGFloat = 250
    
    private var isInitialized: Bool = false
    
    private var topConstraint: NSLayoutConstraint!
    private var activeConstraints: [NSLayoutConstraint] = []
    
    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isInitialized {
            self.isInitialized = true
            
            self.updateConstraints(for: self.bounds.size)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.userInterfaceStyle != self.traitCollection.userInterfaceStyle {
            self.avatarView.layer.borderColor = UIColor.systemBackground.cgColor
        }
    }
    
    func update(viewModel: TwitterProfile.ViewModel) {
        self.avatarView.image = viewModel.user.avatar
        self.displayNameLabel.text = viewModel.user.displayName
        self.userNameLabel.text = viewModel.user.username
        self.bioLabel.text = viewModel.user.bio
        
        self.updateButton(self.locationButton, viewModel: viewModel.user.location)
        self.updateButton(self.urlButton, viewModel: viewModel.user.url)
        
        self.followersView.update(followers: viewModel.user.followers, following: viewModel.user.following)
        
        self.tweetsStack.update(tweets: viewModel.tweets)
    }
    
    func updateConstraints(for size: CGSize) {
        let headerHeight: CGFloat = max(1, (size.width / 750)) * self.headerMinHeight
        
        NSLayoutConstraint.deactivate(self.activeConstraints)
        self.activeConstraints.removeAll()
        
        self.activeConstraints.append(contentsOf: [
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        let isRegular = self.traitCollection.horizontalSizeClass == .regular
        let contentGuide = isRegular ? self.scrollView.readableContentGuide : self.scrollView.layoutMarginsGuide
        
        self.activeConstraints.append(contentsOf: [
            self.contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: contentGuide.widthAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])

        self.activeConstraints.append(contentsOf: [
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.headerView.bottomAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.headerView.topAnchor.constraint(lessThanOrEqualTo: self.scrollView.topAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: headerHeight + self.safeAreaInsets.top).withPriority(.defaultHigh),
            self.headerView.heightAnchor.constraint(greaterThanOrEqualToConstant: headerHeight + self.safeAreaInsets.top),
        ])
        
        var offset = self.scrollView.contentOffset
        offset.y += self.scrollView.contentInset.top - headerHeight
        self.scrollView.setContentOffset(offset, animated: false)
        
        // Content inset must be set after
        self.scrollView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        // Header view
        self.headerView.contentMode = .scaleAspectFill
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
        
        // Gradient to cover the header
        let gradientView = GradientView()
        self.addSubview(gradientView)

        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor)
        ])
        
        // Scroll view
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.addSubview(self.scrollView)
        
        // Content view
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.contentView)
        
        // Avatar view
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.layer.masksToBounds = true
        self.avatarView.layer.cornerRadius = 8
        self.avatarView.layer.borderWidth = 3
        self.avatarView.layer.borderColor = UIColor.systemBackground.cgColor
        self.contentView.addSubview(self.avatarView)
        
        NSLayoutConstraint.activate([
            self.avatarView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.avatarView.centerYAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.avatarView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // User name label
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.userNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.userNameLabel.textColor = UIColor(white: 0.8, alpha: 1)
        self.userNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.userNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentView.addSubview(self.userNameLabel)
        
        NSLayoutConstraint.activate([
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.userNameLabel.bottomAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -8)
        ])
        
        // Display name label
        self.displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.displayNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.displayNameLabel.textColor = .white
        self.displayNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.displayNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentView.addSubview(self.displayNameLabel)
        
        NSLayoutConstraint.activate([
            self.displayNameLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            self.displayNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.displayNameLabel.bottomAnchor.constraint(equalTo: self.userNameLabel.topAnchor)
        ])
        
        // Bio label
        self.bioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.bioLabel.textColor = .label
        self.bioLabel.numberOfLines = 2
        self.bioLabel.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        self.bioLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentView.addSubview(self.bioLabel)

        NSLayoutConstraint.activate([
            self.bioLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            self.bioLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.bioLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8)
        ])

        // Location / url stack
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        self.contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor),
            stack.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            stack.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16)
        ])

        self.locationButton.tintColor = .label
        stack.addArrangedSubview(self.locationButton)
        
        self.urlButton.tintColor = .label
        stack.addArrangedSubview(self.urlButton)

        // Followers view
        self.contentView.addSubview(self.followersView)

        NSLayoutConstraint.activate([
            self.followersView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.followersView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.followersView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16)
        ])
        
        // Tweets stack
        self.contentView.addSubview(self.tweetsStack)

        NSLayoutConstraint.activate([
            self.tweetsStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tweetsStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.tweetsStack.topAnchor.constraint(equalTo: self.followersView.bottomAnchor, constant: 24),
            self.tweetsStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func updateButton(_ button: UIButton, viewModel: TwitterProfile.IconButton.ViewModel) {
        button.setTitle(viewModel.title, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let config = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: viewModel.icon, withConfiguration: config)
        button.setImage(image, for: .normal)
    }
    
}
