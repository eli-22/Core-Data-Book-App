//
//  ReviewListViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation
import CoreData

class ReviewListViewModel: ObservableObject {
    
   @Published var reviews = [ReviewViewModel]()
    
    // This function comes from the Review model, not the Base Model. 
    func getReviewsByBook(vm: BookViewModel) {
        DispatchQueue.main.async {
            self.reviews = Review.getReviewsByBookId(bookId: vm.bookId).map(ReviewViewModel.init)
        }
    }
}
