//
//  AlbumsCollectionViewVC.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/21/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit

class AlbumsCollectionViewVC: UIViewController {
    
    
    @IBOutlet private weak var albumsCollectionView: UICollectionView!
    
    public var albums: [Album] = [Album]() {
        didSet {
            self.albumsCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        albumsCollectionView.backgroundColor = .clear
        
    }
    
    private func setupCollectionView(){
        albumsCollectionView.dataSource = self
        
        albumsCollectionView.register(UINib(nibName: "AlbumsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: AlbumsCollectionViewCell.self))
        
    }
    
    
}

extension AlbumsCollectionViewVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumsCollectionViewCell", for: indexPath) as! AlbumsCollectionViewCell
        cell.album = albums[indexPath.row]
        cell.withBackView = true
        return cell
    }
}
