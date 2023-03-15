//
//  CoreDataManager.swift
//  CoreDataProject
//
//  Created by Elise on 11/12/22.
//

import Foundation
import CoreData
import SwiftUI

// Creating a Base Model allowed us to delete most of the functions in the Core Data Manager. Now, all the Core Data Manager does is initialize the Core Data stack and give us access to the View Context (which is then used by the Base Model). 

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()

    private init() {
        
        persistentContainer = NSPersistentContainer(name: "BookAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data: \(error)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}



