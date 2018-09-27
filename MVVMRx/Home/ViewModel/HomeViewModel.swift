//
//  HomeViewModel.swift
//  Storm
//
//  Created by Mohammad Zakizadeh on 7/17/18.
//  Copyright © 2018 Storm. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class HomeViewModel {
    
    enum homeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    var albums : PublishSubject<[Album]> = PublishSubject()
    var tracks : PublishSubject<[Track]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    var error : PublishSubject<homeError> = PublishSubject()
    
    let disposable = DisposeBag()
    
    
    func requestData(){
        self.loading.onNext(true)
        APIManager.requestData(url: "getHome", method: .get, parameters: nil, completion: { [weak self] (result) in
            self?.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let albums = returnJson["Albums"].arrayValue.compactMap {return Album(data: try! $0.rawData())}
                let tracks = returnJson["Tracks"].arrayValue.compactMap {return Track(data: try! $0.rawData())}
                self?.albums.onNext(albums)
                self?.tracks.onNext(tracks)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self?.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self?.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self?.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
    }
}
