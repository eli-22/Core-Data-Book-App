//
//  AddBookViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation

// All view models should be created as observable objects, because you may want to publish an event from it in the future.

class AddBookViewModel: ObservableObject {
    
    var title: String = ""
    var publisher: String = ""
    @Published var rating: Int? = nil
    // Annotation makes sure the interface updates any time the rating is clicked.
    
    var publicationDate: Date = Date()
    
    func save() {
        
        let manager = CoreDataManager.shared
        
        let book = Book(context: Book.viewContext) // We don't need to use the Core Data Manager inside our view model anymore.
        
        book.title = title
        book.publisher = publisher
        book.rating = Double(rating ?? 0)
        book.publicationDate = publicationDate
        
        book.save()
        // The Book managed object conforms to the Base Model now, so we can call the save function from that protocol. 
    
    }
    
}
