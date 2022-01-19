//
//  GradientView.swift
//  Twitter Profile
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class GradientView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
    }

}
