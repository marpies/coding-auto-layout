//
//  TweetsStackView.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class TweetsStackView: UIStackView {
    
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(tweets: [Tweet.ViewModel]) {
        for view in self.arrangedSubviews {
            if view is TweetView {
                view.removeFromSuperview()
            }
        }
        
        tweets.forEach { tweet in
            let view = TweetView()
            view.update(viewModel: tweet)
            self.addArrangedSubview(view)
        }
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.axis = .vertical
        self.spacing = 16
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.titleLabel.textColor = .secondaryLabel
        self.titleLabel.text = "RECENT TWEETS"
        self.addArrangedSubview(self.titleLabel)
        self.setCustomSpacing(8, after: self.titleLabel)
    }

}
