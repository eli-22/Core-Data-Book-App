//
//  Author+Extensions.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import Foundation
import CoreData

extension Author: BaseModel {
    static func getAuthorsByBookId(bookId: NSManagedObjectID) -> [Author] {
        guard let book = Book.byId(id: bookId) as? Book,
              let authors = book.authors
        else {
            return []
        }
        return (authors.allObjects as? [Author]) ?? []
    }
}
 
