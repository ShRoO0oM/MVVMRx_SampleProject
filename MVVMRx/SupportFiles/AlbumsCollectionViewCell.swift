//
//  AlbumsCollectionViewCell.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/21/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumArtist: UILabel!
    
    var withBackView : Bool! {
        didSet {
            self.backViewGenrator()
        }
    }
    private lazy var backView: UIImageView = {
        let backView = UIImageView(frame: albumImage.frame)
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: albumImage.topAnchor, constant: -10),
            backView.leadingAnchor.constraint(equalTo: albumImage.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: albumImage.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: albumImage.bottomAnchor)
        ])
        backView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        backView.alpha = 0.5
        contentView.bringSubview(toFront: albumImage)
        return backView
    }()
    public var album: Album! {
        didSet {
            self.albumImage.imageFromURL(urlString: album.albumArtWork)
            self.albumArtist.text = ""
            self.albumTitle.text = album.name
        }
    }
    private func backViewGenrator(){
        backView.imageFromURL(urlString: album.albumArtWork)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
