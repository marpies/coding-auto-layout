//
//  RootViewController.swift
//  Twitter Timeline
//
//  Copyright © 2022 Marcel Piestansky. All rights reserved.
//
//  This program is free software. You can redistribute and/or modify it in
//  accordance with the terms of the accompanying license agreement.
// 

import UIKit

class RootViewController: UIViewController {
    
    private let cellId: String = "tweetCell"
    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var dataSource = UITableViewDiffableDataSource<Int, Tweet.ViewModel>(tableView: self.tableView) { tableView, indexPath, tweet in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! TweetTableViewCell
        
        cell.update(viewModel: tweet)
        
        return cell
    }
    
    private var isInitialized: Bool = false
    private var activeConstraints: [NSLayoutConstraint] = []
    private var viewModel: [Tweet.ViewModel] = SampleModel.tweets

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: self.cellId)
        self.tableView.dataSource = self.dataSource
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Tweet.ViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel, toSection: 0)
        
        self.dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !self.isInitialized {
            self.isInitialized = true
            
            self.setupView()
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

