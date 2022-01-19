//
//  Models.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

enum TwitterProfile {
    enum IconButton {
        struct ViewModel {
            let icon: String
            let title: String
        }
    }
    
    enum User {
        struct ViewModel {
            let username: String
            let displayName: String
            let bio: String
            let location: IconButton.ViewModel
            let url: IconButton.ViewModel
            let followers: String
            let following: String
            let avatar: UIImage?
        }
    }
    
    struct ViewModel {
        let user: TwitterProfile.User.ViewModel
        let tweets: [Tweet.ViewModel]
    }
}

enum Tweet {
    enum User {
        struct ViewModel {
            let username: String
            let displayName: String
            let avatar: UIImage?
        }
    }
    
    enum Media {
        struct ViewModel {
            let image: UIImage?
            let size: CGSize
        }
    }
    
    struct ViewModel: Hashable {
        let id: UUID
        let date: String
        let author: Tweet.User.ViewModel
        let text: String?
        let media: Tweet.Media.ViewModel?
        let retweetedBy: Tweet.User.ViewModel?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        static func == (lhs: Tweet.ViewModel, rhs: Tweet.ViewModel) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

enum SampleModel {
    
    private static let user = Tweet.User.ViewModel(username: "@AppStore", displayName: "App Store", avatar: UIImage(named: "avatar"))
    
    private static let tweets: [Tweet.ViewModel] = [
        Tweet.ViewModel(id: UUID(), date: "4h", author: SampleModel.user, text: "Prepare for a trip into the underworld! 😈", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet1"), size: CGSize(width: 315, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "8h", author: SampleModel.user, text: "\"We’re trying to use astrology as a jumping-off point for a new kind of reality.\" ✨", media: nil, retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "14h", author: SampleModel.user, text: nil, media: Tweet.Media.ViewModel(image: UIImage(named: "tweet3"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "16h", author: SampleModel.user, text: "2022 is the year you rethink what yoga can do. 🧘‍♀️\n\nAsana Rebel is a yoga-inspired workout app that caters to all fitness levels.", media: nil, retweetedBy: nil)
    ]
    
    static let profile = TwitterProfile.ViewModel(user: TwitterProfile.User.ViewModel(username: SampleModel.user.username, displayName: SampleModel.user.displayName, bio: "The apps you love. From a place you can trust.", location: TwitterProfile.IconButton.ViewModel(icon: "mappin.and.ellipse", title: "Cupertino, CA"), url: TwitterProfile.IconButton.ViewModel(icon: "link", title: "apple.com/app-store"), followers: "4 499 815", following: "23", avatar: SampleModel.user.avatar), tweets: SampleModel.tweets)
}
