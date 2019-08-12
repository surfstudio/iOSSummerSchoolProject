//
//  PhotoEntry.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 12.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

struct PhotoEntry: Codable {
    let id: String
    let width: Int
    let height: Int
    let description: String?
    let likes: Int
    
    let urls: UrlsEntry
}
