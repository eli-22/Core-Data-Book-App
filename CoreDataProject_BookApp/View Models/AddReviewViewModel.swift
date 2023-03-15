//
//  AddReviewViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation

class AddReviewViewModel: ObservableObject {
    
    var title: String = ""
    var text: String = ""
    
    func addReviewForBook(vm: BookViewModel) {
        
        let book: Book? = Book.byId(id: vm.bookId)
        // byId function from Base Model
        
        if let book = book {
            let review = Review(context: Review.viewContext)
            review.title = title
            review.text = text
            review.book = book
            review.save()
        }
    }
}
