//
//  AlbumButton.swift
//  Music Album
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class AlbumButton: UIButton {
    
    private var isInitialized: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isInitialized {
            self.isInitialized = true
            
            self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        }
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 12
        
        let spacing: CGFloat = 16 / 2
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
        self.contentEdgeInsets = UIEdgeInsets(top: 12, left: spacing, bottom: 12, right: spacing)
    }
    
}
