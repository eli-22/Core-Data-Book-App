//
//  File.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import Foundation
import CoreData

protocol BaseModel: NSManagedObject {
    func save()
    func delete()
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel { // Provide a default implementation so concrete classes don't have to implement very similar functions individually. Implementation will be the same whether we want to get all books or get all reviews, delete a review, delete an author, etc.
    
    static var viewContext: NSManagedObjectContext {
            return CoreDataManager.shared.viewContext
        }
    
    func save() {
        do {
            try Self.viewContext.save()
        } catch {
            Self.viewContext.rollback()
            print(error)
        }
    }
    
    func delete() {
        Self.viewContext.delete(self)
        save()
    }
    
    static func all<T>() -> [T] where T: NSManagedObject {
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))
        // Create a request based on the type passed.
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject {
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
}
