//
//  CollectionEntry.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 12.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

struct CollectionEntry: Codable {
    
    let id: Int
    let title: String
    let description: String?
    let cover_photo: PhotoEntry
    
}

// 1. Создать ячейку с фото + загрузить из сети список фото
// 2. Header модифицировать (вставить рандомную картинку из списка фото)
// 3. Можно сделать смену фотографий каждые 5 секунд в header-е
// 4. Сделать декодинг User-а и добавить информацию в header
