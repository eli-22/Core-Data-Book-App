//
//  BookViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/26/22.
//

import Foundation
import CoreData

struct BookViewModel {
    
    let book: Book
    
    var bookId: NSManagedObjectID { // Unique id for each object.
        return book.objectID
    }
    
    var title: String {
        return book.title ?? ""
    }
    
    var publisher: String {
        return book.publisher ?? "Not available"
    }
    
    var publicationDate: String? {
        return book.publicationDate?.asFormattedString()
    }
    
    var rating: Int? {
        return Int(book.rating)
    }
}
