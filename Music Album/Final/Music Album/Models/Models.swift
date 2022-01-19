//
//  Models.swift
//  Music Album
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

enum Album {
    enum Header {
        struct ViewModel {
            let coverImage: UIImage?
            let title: String
            let artistName: String
            let genre: String
            let description: String
        }
    }
    
    enum Track {
        struct ViewModel: Hashable {
            let id: UUID
            let order: String
            let title: String
            let length: String
        }
    }
    
    struct ViewModel {
        let header: Album.Header.ViewModel
        let tracks: [Album.Track.ViewModel]
    }
}

enum SampleModel {
    static let album: Album.ViewModel = Album.ViewModel(
        header: Album.Header.ViewModel(
            coverImage: UIImage(named: "album"),
            title: "Whatever People Say I Am, That's What I'm Not",
            artistName: "Arctic Monkeys",
            genre: "ALTERNATIVE • 2006",
            description: "Back in 2006, Arctic Monkeys were cast as revolutionaries for uploading music to the internet. There's nothing quite so radical about their debut, which fuses a punk snarl with the sharp tunes and agitated rhythms of New Wave."),
        tracks: [
            Album.Track.ViewModel(id: UUID(), order: "1", title: "The View from the Afternoon", length: "3:38"),
            Album.Track.ViewModel(id: UUID(), order: "2", title: "I Bet You Look Good on the Dancefloor", length: "2:53"),
            Album.Track.ViewModel(id: UUID(), order: "3", title: "Fake Tales of San Francisco", length: "2:57"),
            Album.Track.ViewModel(id: UUID(), order: "4", title: "Dancing Shoes", length: "2:21"),
            Album.Track.ViewModel(id: UUID(), order: "5", title: "You Probably Couldn't See for the Lights but You Were Staring Straight at Me", length: "2:10"),
            Album.Track.ViewModel(id: UUID(), order: "6", title: "Still Take You Home", length: "2:53"),
            Album.Track.ViewModel(id: UUID(), order: "7", title: "Riot Van", length: "2:14"),
            Album.Track.ViewModel(id: UUID(), order: "8", title: "Red Light Indicates Doors Are Secured", length: "2:23"),
            Album.Track.ViewModel(id: UUID(), order: "9", title: "Mardy Bum", length: "2:55"),
            Album.Track.ViewModel(id: UUID(), order: "10", title: "Perhaps Vampires Is a Bit Strong But…", length: "4:28"),
            Album.Track.ViewModel(id: UUID(), order: "11", title: "When the Sun Goes Down", length: "3:20"),
            Album.Track.ViewModel(id: UUID(), order: "12", title: "From the Ritz to the Rubble", length: "3:13"),
            Album.Track.ViewModel(id: UUID(), order: "13", title: "A Certain Romance", length: "5:31")
        ])
}
