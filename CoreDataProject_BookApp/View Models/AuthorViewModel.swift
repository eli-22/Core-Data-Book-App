//
//  AuthorViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 12/1/22.
//

import Foundation
import CoreData

struct AuthorViewModel {
    
    let author: Author
    
    var authorId: NSManagedObjectID {
        return author.objectID
    }
    
    var name: String {
        return author.name ?? ""
    }
    
    var books: [BookViewModel] {
        return Book.byAuthorName(name: name).map(BookViewModel.init)
        // Array of Book View Models representing books written by the author.
    }
}
