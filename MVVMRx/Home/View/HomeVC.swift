//
//  HomeVC.swift
//  MVVMRx
//
//  Created by Mohammad Zakizadeh on 9/27/18.
//  Copyright © 2018 storm. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
    
    let disposeBag = DisposeBag()
    
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
        
        homeViewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        
        // observing errors to show
        
        homeViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .error)
                case .serverMessage(let message):
                    MessageView.sharedInstance.showOnView(message: message, theme: .warning)
                }
            })
            .disposed(by: disposeBag)
        
        
        // binding albums to album container
        
        homeViewModel
            .albums
            .observeOn(MainScheduler.instance)
            .bind(to: albumsViewController.albums)
            .disposed(by: disposeBag)
        
        // binding tracks to track container
        
        homeViewModel
            .tracks
            .observeOn(MainScheduler.instance)
            .bind(to: tracksViewController.tracks)
            .disposed(by: disposeBag)
       
    }
}
