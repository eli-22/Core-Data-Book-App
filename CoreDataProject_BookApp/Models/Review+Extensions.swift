//
//  Review+Extensions.swift
//  CoreDataProject
//
//  Created by Elise on 11/29/22.
//

import Foundation
import CoreData

// Create an extension because the Review class already exists. It was generated automatically when we added the Review entity to our model.

extension Review: BaseModel {
    
    static func getReviewsByBookId(bookId: NSManagedObjectID) -> [Review] {
        
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        request.predicate = NSPredicate(format: "book = %@", bookId)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
