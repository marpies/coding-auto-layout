//
//  RootViewController.swift
//  Music Album
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController {
    
    private let cellId: String = "trackCell"
    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var dataSource = UITableViewDiffableDataSource<Int, Album.Track.ViewModel>(tableView: self.tableView) { tableView, indexPath, track in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! AlbumTrackTableViewCell
        
        cell.update(viewModel: track)
        
        return cell
    }
    
    private var isInitialized: Bool = false
    private var activeConstraints: [NSLayoutConstraint] = []
    
    private let viewModel: Album.ViewModel = SampleModel.album

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let header = AlbumHeaderView()
        header.update(viewModel: self.viewModel.header)
        self.tableView.tableHeaderView = header
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(AlbumTrackTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.tableView.dataSource = self.dataSource
        self.tableView.rowHeight = 40
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !self.isInitialized {
            self.isInitialized = false
            
            self.setupView()
            
            var snapshot = NSDiffableDataSourceSnapshot<Int, Album.Track.ViewModel>()
            snapshot.appendSections([0])
            snapshot.appendItems(self.viewModel.tracks, toSection: 0)
            self.dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
        
        if let headerView = self.tableView.tableHeaderView as? AlbumHeaderView {
            let sizeToFit: CGSize = CGSize(width: headerView.bounds.width, height: 0)
            let layoutSize: CGSize = headerView.systemLayoutSizeFitting(sizeToFit, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
            if headerView.frame.size.height != layoutSize.height {
                var frame: CGRect = headerView.frame
                frame.size.height = layoutSize.height
                headerView.frame = frame
                self.tableView.tableHeaderView = headerView
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.setupView()
    }
    
    private func setupView() {
        NSLayoutConstraint.deactivate(self.activeConstraints)
        self.activeConstraints.removeAll()
        
        if self.traitCollection.horizontalSizeClass == .regular {
            if UIDevice.current.orientation.isLandscape {
                self.activeConstraints.append(contentsOf: [
                    self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2 / 3),
                    self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    self.tableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                    self.tableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
                ])
            } else {
                self.activeConstraints.append(contentsOf: [
                    self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    self.tableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                    self.tableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
                ])
            }
        } else {
            self.activeConstraints.append(contentsOf: [
                self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.tableView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
                self.tableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
            ])
        }
        
        NSLayoutConstraint.activate(self.activeConstraints)
    }


}

