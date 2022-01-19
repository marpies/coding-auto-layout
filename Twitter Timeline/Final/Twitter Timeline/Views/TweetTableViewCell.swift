//
//  TweetTableViewCell.swift
//  Twitter Timeline
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    private let avatarView = UIImageView()
    private let displayNameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let contentStack = UIStackView()
    
    private var retweetedByView: RetweetedByView?
    private var tweetTextLabel: UILabel?
    private var mediaView: UIImageView?
    private var mediaConstraints: [NSLayoutConstraint]?
    
    private var media: Tweet.Media.ViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let media = self.media, previousTraitCollection?.horizontalSizeClass != self.traitCollection.horizontalSizeClass {
            self.updateMediaConstraints(media)
        }
    }
    
    func update(viewModel: Tweet.ViewModel) {
        self.avatarView.image = viewModel.author.avatar
        self.userNameLabel.text = viewModel.author.username
        self.displayNameLabel.text = viewModel.author.displayName
        self.dateLabel.text = viewModel.date
        self.media = viewModel.media
        
        if let text = viewModel.text {
            self.addTweetText(text)
        } else {
            self.removeTweetText()
        }
        
        if let media = viewModel.media {
            self.addTweetMedia(media)
        } else {
            self.removeTweetMedia()
        }
        
        if let retweet = viewModel.retweetedBy {
            self.addRetweetedByView(retweet)
        } else {
            self.removeRetweetedByView()
        }
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.selectionStyle = .none
        
        // Avatar view
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.layer.cornerRadius = 4
        self.avatarView.layer.masksToBounds = true
        self.avatarView.contentMode = .scaleAspectFill
        self.avatarView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(self.avatarView)
        
        NSLayoutConstraint.activate([
            self.avatarView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.avatarView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.avatarView.widthAnchor.constraint(equalToConstant: 60),
            self.avatarView.heightAnchor.constraint(equalToConstant: 60),
            self.avatarView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        // Content stack
        self.contentStack.axis = .vertical
        self.contentStack.alignment = .leading
        self.contentStack.spacing = 12
        self.contentStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.contentStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            self.contentStack.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 8),
            self.contentStack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.contentStack.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.contentStack.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        // Labels stack
        let labelsStack = UIStackView()
        labelsStack.axis = .horizontal
        labelsStack.spacing = 4
        self.contentStack.addArrangedSubview(labelsStack)
        labelsStack.widthAnchor.constraint(equalTo: self.contentStack.widthAnchor).isActive = true
        
        self.displayNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.displayNameLabel.textColor = .label
        self.displayNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelsStack.addArrangedSubview(self.displayNameLabel)
        
        self.userNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        self.userNameLabel.textColor = .secondaryLabel
        self.userNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.userNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        labelsStack.addArrangedSubview(self.userNameLabel)
        
        self.dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.dateLabel.textColor = .secondaryLabel
        self.dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelsStack.addArrangedSubview(self.dateLabel)
    }
    
    private func addTweetText(_ text: String) {
        if self.tweetTextLabel == nil {
            self.tweetTextLabel = UILabel()
            self.tweetTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            self.tweetTextLabel?.textColor = .label
            self.tweetTextLabel?.numberOfLines = 0
            self.contentStack.insertArrangedSubview(self.tweetTextLabel!, at: 1)
            self.tweetTextLabel?.widthAnchor.constraint(equalTo: self.contentStack.widthAnchor).isActive = true
        }
        
        self.tweetTextLabel?.text = text
    }
    
    private func removeTweetText() {
        guard let label = self.tweetTextLabel else { return }
        
        self.tweetTextLabel = nil
        label.removeFromSuperview()
    }
    
    private func addTweetMedia(_ media: Tweet.Media.ViewModel) {
        if self.mediaView == nil {
            self.mediaView = UIImageView()
            self.mediaView?.layer.cornerRadius = 4
            self.mediaView?.layer.masksToBounds = true
            
            let insertIndex: Int = (self.tweetTextLabel == nil) ? 1 : 2
            self.contentStack.insertArrangedSubview(self.mediaView!, at: insertIndex)
        }
        
        self.mediaView?.image = media.image
        
        self.updateMediaConstraints(media)
    }
    
    private func removeTweetMedia() {
        guard let view = self.mediaView else { return }
        
        self.mediaView = nil
        view.removeFromSuperview()
        
        self.mediaConstraints = nil
    }
    
    private func updateMediaConstraints(_ media: Tweet.Media.ViewModel) {
        if let constraints = self.mediaConstraints {
            NSLayoutConstraint.deactivate(constraints)
        }
        
        self.mediaConstraints = [
            self.mediaView!.widthAnchor.constraint(equalToConstant: media.size.width).withPriority(.defaultHigh),
            self.mediaView!.heightAnchor.constraint(equalTo: self.mediaView!.widthAnchor, multiplier: media.size.height / media.size.width)
        ]
        
        if self.traitCollection.horizontalSizeClass == .regular {
            self.mediaConstraints?.append(
                self.mediaView!.widthAnchor.constraint(lessThanOrEqualTo: self.contentStack.widthAnchor, multiplier: 0.7)
            )
        } else {
            self.mediaConstraints?.append(
                self.mediaView!.widthAnchor.constraint(lessThanOrEqualTo: self.contentStack.widthAnchor)
            )
        }
        
        NSLayoutConstraint.activate(self.mediaConstraints!)
    }
    
    private func addRetweetedByView(_ user: Tweet.User.ViewModel) {
        if self.retweetedByView == nil {
            self.retweetedByView = RetweetedByView()
            self.contentStack.addArrangedSubview(self.retweetedByView!)
        }
        
        self.retweetedByView?.update(viewModel: user)
    }
    
    private func removeRetweetedByView() {
        guard let view = self.retweetedByView else { return }
        
        view.removeFromSuperview()
        self.retweetedByView = nil
    }
    
}

fileprivate extension NSLayoutConstraint {
    
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}
