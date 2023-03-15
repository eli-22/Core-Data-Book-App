//
//  AuthorListViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import Foundation
import CoreData

class AuthorListViewModel: ObservableObject {
    
    @Published var authors = [AuthorViewModel]()
    
    func getAuthorsByBook(vm: BookViewModel) {
        DispatchQueue.main.async {
            self.authors = Author.getAuthorsByBookId(bookId: vm.bookId).map(AuthorViewModel.init)
            // getAuthorsByBookId function comes from Author+Extensions, returns array of authors.
            // Go through array and initialize Author View Models, assign array to self.authors.
        }
    }
    
}
