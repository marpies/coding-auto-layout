//
//  BoxedUITextField.swift
//  SignUpScreen
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class BoxedUITextField: UITextField {
    
    private enum Padding {
        static let horizontal: CGFloat = 8
        static let vertical: CGFloat = 8
    }

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + Padding.horizontal,
            y: bounds.origin.y + Padding.vertical,
            width: bounds.size.width - Padding.horizontal * 2,
            height: bounds.size.height - Padding.vertical * 2
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.separator.cgColor
        self.layer.cornerRadius = 4
    }

}
