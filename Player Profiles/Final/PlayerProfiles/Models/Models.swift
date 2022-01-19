//
//  Models.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import Foundation
import UIKit

enum TitledValue {
    struct ViewModel {
        let title: String
        let value: String
    }
}

enum PlayerProfile {
    struct ViewModel {
        let country: UIImage?
        let name: String
        let values: [TitledValue.ViewModel]
    }
}

enum SampleModel {
    static let player1: PlayerProfile.ViewModel = PlayerProfile.ViewModel(country: UIImage(named: "portugal"), name: "Cristiano Ronaldo", values: [
        TitledValue.ViewModel(title: "Age", value: "36"),
        TitledValue.ViewModel(title: "Seasons", value: "20"),
        TitledValue.ViewModel(title: "Games", value: "1097"),
        TitledValue.ViewModel(title: "Goals", value: "802")
    ])
    
    static let player2: PlayerProfile.ViewModel = PlayerProfile.ViewModel(country: UIImage(named: "argentina"), name: "Lionel Messi", values: [
        TitledValue.ViewModel(title: "Age", value: "34"),
        TitledValue.ViewModel(title: "Seasons", value: "18"),
        TitledValue.ViewModel(title: "Games", value: "951"),
        TitledValue.ViewModel(title: "Goals", value: "758")
    ])
}
