//
//  AlertModels.swift
//  CustomAlert
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import Foundation

enum Alert {
    
    struct ViewModel {
        let title: String
        let message: String
        let buttons: [Button.ViewModel]
    }
    
}

enum SampleModel {
    static let removeAppAlert: Alert.ViewModel = Alert.ViewModel(title: "Remove App?", message: "Removing from Home screen will keep the app in your App Library.", buttons: [
        Button.ViewModel(title: "Cancel", style: .default),
        Button.ViewModel(title: "Remove from Home Screen", style: .regular),
        Button.ViewModel(title: "Delete App", style: .destructive)
    ])
    
    static let purchaseAlert: Alert.ViewModel = Alert.ViewModel(title: "Confirm Your In-App Purchase", message: "Do you want to buy one Pack of Gems for $4.99?", buttons: [
        Button.ViewModel(title: "Cancel", style: .regular),
        Button.ViewModel(title: "Buy", style: .default)
    ])
}
