//
//  DataProvider.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 13.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreData

struct DataProvider {
    
    private let service: BaseService
    private let context: NSManagedObjectContext
    
    init(service: BaseService, context: NSManagedObjectContext) {
        self.service = service
        self.context = context
    }
    
    func getCollections(
        onCompleted: @escaping ([Collection]) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        service.getFeaturedCollections(
            onCompleted: { (serviceCollections) in
                DispatchQueue.main.async {
                    // + 1. Из CD удаляем те коллекции, которые уже пришли из сети (для того, чтобы обновить данные)
                    self.removeNewCollections(serviceCollections: serviceCollections)
                    
                    // 2. Из CD удалить те фотографии, которые уже пришли из сети
                    self.removeNewPhotos(serviceCollections: serviceCollections)
                    
                    // 3. Заносим с CD новую информацию о коллекциях + о фото
                    self.addCollectionsAndPhotosToCD(serviceCollections: serviceCollections)
                    
                    // 4. Сохраняем контекст
                    if self.context.hasChanges {
                        try? self.context.save()
                    }
                    
                    // 5. Вызываем onCompleted
                    onCompleted(self.getAllCollectionsFromCD())
                }
            },
            onError: { (error) in
                DispatchQueue.main.async {
                    // загрузим все коллекции из Core Data
                    onCompleted(self.getAllCollectionsFromCD())
                }
            }
        )
    }
    
    private func getAllCollectionsFromCD() -> [Collection] {
        let fetchRequest: NSFetchRequest<Collection> = Collection.fetchRequest()
        return (try? self.context.fetch(fetchRequest)) ?? []
    }
    
    private func removeNewCollections(serviceCollections: [CollectionEntry]) {
        let identifiers = serviceCollections.map { $0.id }
        let fetchRequest: NSFetchRequest<Collection> = Collection.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id in %@", argumentArray: [identifiers])
        let coreDataCollections = (try? context.fetch(fetchRequest)) ?? []
        coreDataCollections.forEach { context.delete($0) }
    }
    
    private func removeNewPhotos(serviceCollections: [CollectionEntry]) {
        let identifiers = serviceCollections.map { $0.cover_photo.id }
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id in %@", argumentArray: [identifiers])
        let coreDataPhotos = (try? context.fetch(fetchRequest)) ?? []
        coreDataPhotos.forEach { context.delete($0) }
    }
    
    private func addCollectionsAndPhotosToCD(serviceCollections: [CollectionEntry]) {
        for serviceCollection in serviceCollections {
            let coreDataCollection = Collection(context: context)
            coreDataCollection.id = Int32(serviceCollection.id)
            coreDataCollection.title = serviceCollection.title
            
            let coreDataPhoto = Photo(context: context)
            coreDataPhoto.id = serviceCollection.cover_photo.id
            coreDataPhoto.urlString = serviceCollection.cover_photo.urls.regular
            
            coreDataCollection.photo = coreDataPhoto
        }
    }
    
}
