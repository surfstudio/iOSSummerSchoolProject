//
//  BaseService.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 12.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

struct BaseService {
    
    func getPhotos(
        onCompleted: @escaping ([PhotoEntry]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let url = URL(string: "\(NetworkConstants.baseUrl)/photos?client_id=\(NetworkConstants.accessKey)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                onError(error)
                return
            }
            
            guard
                let data = data,
                let photos = try? JSONDecoder().decode([PhotoEntry].self, from: data)
            else {
                print("undable decode data")
                onError(NSError())
                return
            }
            
            // массив из фотографий photos
            onCompleted(photos)
            
        }
        task.resume()
    }
    
    func getFeaturedCollections(
        onCompleted: @escaping ([CollectionEntry]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        let url = URL(string: "\(NetworkConstants.baseUrl)/collections/featured?client_id=\(NetworkConstants.accessKey)")!
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard
                let data = data,
                let collections = try? JSONDecoder().decode([CollectionEntry].self, from: data)
            else {
                print("undable decode")
                onError(NSError())
                return
            }
            
            onCompleted(collections)
        }
        task.resume()
    }
    
}
