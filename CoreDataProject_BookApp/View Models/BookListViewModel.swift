//
//  BookListViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation
import CoreData

class BookListViewModel: ObservableObject {
    
    @Published var books = [BookViewModel]()
    // Without @Published property wrapper, the UI won't be notified that it needs to refresh. because it won't realize a new, updated copy is available.
    
    @Published var filterEnabled: Bool = false // Moved from Book List Screen
    @Published var sortEnabled: Bool = false // This is so we can only show the sorting feature after the user clicks the "sort" button. 
    @Published var selectedSortOption: SortOptions = .title
    @Published var selectedSortDirection: SortDirection = .ascending
    // These properties bind to the UI, so when we select an option from the menu, that property is populated.

    func sort() {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        
        // Sorting with binding properties:
        request.sortDescriptors = [NSSortDescriptor (key: selectedSortOption.rawValue, ascending:
                                                        selectedSortDirection.value)]
        
        // To sort without binding, add NSSortDescriptors to array in order of priority:
        // request.sortDescriptors = [NSSortDescriptor (key: "title", ascending: true), NSSortDescriptor (key: "rating", ascending: false)]
        
        let fetchedResultsController: NSFetchedResultsController<Book> =
        NSFetchedResultsController(fetchRequest: request, managedObjectContext:
                                    CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.books = (fetchedResultsController.fetchedObjects ?? []).map (BookViewModel.init)
        }
    }
    
    func getAllBooks() {
        let books: [Book]  = Book.all() // all function in Base Model
        DispatchQueue.main.async {
            self.books = books.map(BookViewModel.init)
            // This will be the array of Book View Models.
            // Iterate through the array and call the init method.
        }
    }
    
    func deleteBook(book: BookViewModel) {
        
        let book: Book? = Book.byId(id: book.bookId) // byId function in Base Model returns T?
        if let book = book {
            book.delete()
        }
    }
}

enum SortDirection: CaseIterable {
    
    case ascending
    case descending
    
    var value: Bool {
        switch self {
            case .ascending:
                return true
            case .descending:
                return false
        }
    }
    
    var displayText: String {
        switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
        }
    }
}

enum SortOptions: String, CaseIterable {
    
    case title
    case publicationDate
    case rating
    
    var displayText: String {
        switch self {
            case .title:
                return "Title"
            case .publicationDate:
                return "Publication Date"
            case .rating:
                return "Rating"
        }
    }
}
