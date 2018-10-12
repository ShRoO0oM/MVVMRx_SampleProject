//
//  TracksTableViewCell.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/18/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit


class TracksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var trackImage : UIImageView!
    @IBOutlet weak var trackArtist : UILabel!
    @IBOutlet weak var trackTitle: UILabel!
    
    
    public var cellTrack : Track! {
        didSet {
            self.trackImage.clipsToBounds = true
            self.trackImage.layer.cornerRadius = 3
            self.trackImage.loadImage(fromURL: cellTrack.trackArtWork)
            self.trackTitle.text = cellTrack.name
            self.trackArtist.text = cellTrack.artist
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    override func prepareForReuse() {
        trackImage.image = UIImage()
    }
}
