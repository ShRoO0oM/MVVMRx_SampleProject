//
//  HomeVC.swift
//  MVVMRx
//
//  Created by Mohammad Zakizadeh on 9/27/18.
//  Copyright © 2018 storm. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - SubViews
    @IBOutlet weak var tracksVCView: UIView!
    
    @IBOutlet weak var albumsVCView: UIView!
    
    private lazy var albumsViewController: AlbumsCollectionViewVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "AlbumsCollectionViewVC") as! AlbumsCollectionViewVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController, to: albumsVCView)
        
        return viewController
    }()
    
    
    private lazy var tracksViewController: TracksTableViewVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "TracksTableViewVC") as! TracksTableViewVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController, to: tracksVCView)
        
        return viewController
    }()
    
    
    var homeViewModel = HomeViewModel()
    
    
    // MARK: - View's Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBlurArea(area: self.view.frame, style: .dark)
        setupBindings()
        homeViewModel.requestData()
    }
    
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        // binding loading to vc
        
        homeViewModel.loading = { [weak self] (isLoading) in
            guard let `self` = self else {return}
            isLoading ? self.startAnimating() : self.stopAnimating()
        }
        
        
        // observing errors to show
        
        
        homeViewModel.onError = { (error) in
            switch error {
            case .internetError(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .error)
            case .serverMessage(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .warning)
            }
        }
        
        
        // binding albums to album container
        
        homeViewModel.onAlbums = { [weak self] (albums) in
            guard let `self` = self else {return}
            self.albumsViewController.albums = albums
        }
        // binding tracks to track container
        
        homeViewModel.onTracks = { [weak self] (tracks) in
            guard let `self` = self else {return}
            self.tracksViewController.tracks = tracks
        }
       
    }
}
