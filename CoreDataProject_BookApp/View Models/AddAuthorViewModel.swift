//
//  AddAuthorViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import Foundation
import CoreData

class AddAuthorViewModel: ObservableObject {
    
    var name: String = ""
    
    func addAuthorToBook(bookId: NSManagedObjectID) {
        let book: Book? = Book.byId(id: bookId)
        
        if let book = book {
            let author = Author(context: Author.viewContext)
           // For this to work, Author must conform to the Base Model protocol.
            author.name = name
            author.addToBooks(book)
            
            try? author.save()
        }
    }
}
