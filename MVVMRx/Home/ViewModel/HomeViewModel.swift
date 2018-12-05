//
//  HomeViewModel.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/17/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import Foundation



class HomeViewModel {
    
    public enum homeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public var onAlbums : (([Album])->Void)?
    
    public var onTracks : (([Track])->Void)?
    
    public var loading:   ((Bool)->Void)?
    
    public var onError : ((homeError)->Void)?
    
    
    public func requestData(){
        
        self.loading?(true)
        
        APIManager.requestData(url: "dcd86ebedb5e519fd7b09b79dd4e4558/raw/b7505a54339f965413f5d9feb05b67fb7d0e464e/MvvmExampleApi.json", method: .get, parameters: nil, completion: { (result) in
            
            DispatchQueue.main.async {
                
                self.loading?(false)
                
                switch result {
                case .success(let returnJson) :
                    
                    let albums = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                    
                    let tracks = returnJson["Tracks"].arrayValue.compactMap {return Track(data: try! $0.rawData())}
                    
                    self.onAlbums?(albums)
                    
                    self.onTracks?(tracks)
                    
                case .failure(let failure) :
                    
                    switch failure {
                        
                    case .connectionError:
                        self.onError?(.internetError("Check your Internet connection."))
                        
                    case .authorizationError(let errorJson):
                        
                        self.onError?(.serverMessage(errorJson["message"].stringValue))
                        
                    default:
                        
                        self.onError?(.serverMessage("Unknown Error"))
                    }
                }
            }
        })
    }
}
