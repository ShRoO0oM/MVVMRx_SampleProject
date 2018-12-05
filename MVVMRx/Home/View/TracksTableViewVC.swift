//
//  TracksTableViewVC.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/21/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import UIKit


class TracksTableViewVC: UIViewController {
    
    
    @IBOutlet private weak var tracksTableView: UITableView!
    
    
    public var tracks: [Track] = [Track]() {
        didSet {
            self.tracksTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView(){
        
        
        tracksTableView.dataSource = self
        
        tracksTableView.register(UINib(nibName: "TracksTableViewCell", bundle: nil), forCellReuseIdentifier: String.init(describing: TracksTableViewCell.self))
        
    }
}

extension TracksTableViewVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: TracksTableViewCell.self)) as! TracksTableViewCell
        
        cell.cellTrack = self.tracks[indexPath.row]
        
        return cell
    }
}



