//
//  CoreDataStack.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 13.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("unable to load persistent store")
            }
        })
        return container
    }()
    
}
