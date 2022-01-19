//
//  Models.swift
//  Twitter Timeline
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

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
    
    static let user1 = Tweet.User.ViewModel(username: "@AppStore", displayName: "App Store", avatar: UIImage(named: "user_appstore"))
    static let user2 = Tweet.User.ViewModel(username: "@AppleArcade", displayName: "Apple Arcade", avatar: UIImage(named: "user_applearcade"))
    
    static let tweets: [Tweet.ViewModel] = [
        Tweet.ViewModel(id: UUID(), date: "5h", author: SampleModel.user1, text: "\"We’re trying to use astrology as a jumping-off point for a new kind of reality.\" ✨\n\nWe spoke to @CoStarAstrology founder and CEO Banu Guler about why people turn to the stars, and how to adapt a 4,000-year-old system into an app: apple.co/CoStarAstrology", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet1"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "8h", author: SampleModel.user1, text: "Prepare for a trip into the underworld! 😈\n\nIn Pinstripe you'll guide Tim as he navigates this dark realm, faces his inner demons, and deals with the actual suit-wearing demon who’s running the place: apple.co/Pinstripe", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet2"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "12h", author: SampleModel.user2, text: "Discover the top Apple Arcade games of 2021! 🎉⭐️\n\nPlay now: apple.co/topgames21", media: nil, retweetedBy: SampleModel.user1),
        Tweet.ViewModel(id: UUID(), date: "14h", author: SampleModel.user1, text: nil, media: Tweet.Media.ViewModel(image: UIImage(named: "tweet4"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "16h", author: SampleModel.user1, text: "2022 is the year you rethink what yoga can do. 🧘‍♀️\n\nAsana Rebel is a yoga-inspired workout app that caters to all fitness levels. Even if you don’t know your chakra from your elbow, it can help you lose weight, improve flexibility, and build strength: apple.co/-AsanaRebel", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet5"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "22h", author: SampleModel.user1, text: "\"We’re trying to use astrology as a jumping-off point for a new kind of reality.\" ✨\n\nWe spoke to @CoStarAstrology founder and CEO Banu Guler about why people turn to the stars, and how to adapt a 4,000-year-old system into an app: apple.co/CoStarAstrology", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet1"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "1d", author: SampleModel.user1, text: "Prepare for a trip into the underworld! 😈\n\nIn Pinstripe you'll guide Tim as he navigates this dark realm, faces his inner demons, and deals with the actual suit-wearing demon who’s running the place: apple.co/Pinstripe", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet2"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "1d", author: SampleModel.user2, text: "Discover the top Apple Arcade games of 2021! 🎉⭐️\n\nFrom slam dunks in NBA 2K22 Arcade Edition to stealthy shenanigans in Sneaky Sasquatch, these games had us scoring, battling, and always laughing.\n\nPlay now: apple.co/topgames21", media: nil, retweetedBy: SampleModel.user1),
        Tweet.ViewModel(id: UUID(), date: "1d", author: SampleModel.user1, text: nil, media: Tweet.Media.ViewModel(image: UIImage(named: "tweet4"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "2d", author: SampleModel.user2, text: "2022 is the year you rethink what yoga can do. 🧘‍♀️\n\nAsana Rebel is a yoga-inspired workout app that caters to all fitness levels. Even if you don’t know your chakra from your elbow, it can help you lose weight, improve flexibility, and build strength: apple.co/-AsanaRebel", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet5"), size: CGSize(width: 514, height: 315)), retweetedBy: SampleModel.user1),
        Tweet.ViewModel(id: UUID(), date: "2d", author: SampleModel.user1, text: "\"We’re trying to use astrology as a jumping-off point for a new kind of reality.\" ✨\n\nWe spoke to @CoStarAstrology founder and CEO Banu Guler about why people turn to the stars, and how to adapt a 4,000-year-old system into an app: apple.co/CoStarAstrology", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet1"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "3d", author: SampleModel.user1, text: "Prepare for a trip into the underworld! 😈\n\nIn Pinstripe you'll guide Tim as he navigates this dark realm, faces his inner demons, and deals with the actual suit-wearing demon who’s running the place: apple.co/Pinstripe", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet2"), size: CGSize(width: 514, height: 315)), retweetedBy: nil),
        Tweet.ViewModel(id: UUID(), date: "3d", author: SampleModel.user2, text: "Discover the top Apple Arcade games of 2021! 🎉⭐️\n\nFrom slam dunks in NBA 2K22 Arcade Edition to stealthy shenanigans in Sneaky Sasquatch, these games had us scoring, battling, and always laughing.\n\nPlay now: apple.co/topgames21", media: nil, retweetedBy: SampleModel.user1),
        Tweet.ViewModel(id: UUID(), date: "3d", author: SampleModel.user2, text: nil, media: Tweet.Media.ViewModel(image: UIImage(named: "tweet4"), size: CGSize(width: 514, height: 315)), retweetedBy: SampleModel.user1),
        Tweet.ViewModel(id: UUID(), date: "4d", author: SampleModel.user1, text: "2022 is the year you rethink what yoga can do. 🧘‍♀️\n\nAsana Rebel is a yoga-inspired workout app that caters to all fitness levels. Even if you don’t know your chakra from your elbow, it can help you lose weight, improve flexibility, and build strength: apple.co/-AsanaRebel", media: Tweet.Media.ViewModel(image: UIImage(named: "tweet5"), size: CGSize(width: 514, height: 315)), retweetedBy: nil)
    ]
}
