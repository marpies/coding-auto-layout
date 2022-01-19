//
//  ButtonModels.swift
//  CustomAlert
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

enum Button {
    
    enum Style {
        case `default`, destructive, regular
    }
	
    struct ViewModel {
        let title: String
        let style: Button.Style
    }
    
}
