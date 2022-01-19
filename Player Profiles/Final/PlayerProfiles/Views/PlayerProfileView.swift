//
//  PlayerProfileView.swift
//  PlayerProfiles
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class PlayerProfileView: UIStackView {
    
    private let countryNameView = CountryNameView()
    private let boxView = BoxedValuesView()

    init() {
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(viewModel: PlayerProfile.ViewModel) {
        self.countryNameView.update(image: viewModel.country, name: viewModel.name)
        self.boxView.update(viewModels: viewModel.values)
    }
    
    //
    // MARK: - Private
    //
    
    private func setupView() {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 8
        
        self.addArrangedSubview(self.countryNameView)
        self.addArrangedSubview(self.boxView)
        
        self.boxView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }

}
