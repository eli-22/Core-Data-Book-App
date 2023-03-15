//
//  FilterViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 12/4/22.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    func filterBooksByPublicationDate(publicationDate: Date) -> [BookViewModel] {
        return Book.byPublicationDate(publicationDate: publicationDate).map(BookViewModel.init)
    }
    
    func filterBooksByDateRange(lowerBoundDate: Date, upperBoundDate: Date) -> [BookViewModel] {
        return Book.byDateRange(lower: lowerBoundDate, upper: upperBoundDate).map(BookViewModel.init)
    }
    
    func filterBooksByDateRangeOrMinimumRating(lowerBoundDate: Date?, upperBoundDate: Date?, minimumRating: Int?) -> [BookViewModel] {
        return Book.byDateRangeOrMinimumRating(lowerBound: lowerBoundDate, upperBound: upperBoundDate, minimumRating: minimumRating).map(BookViewModel.init)
    }
    
    func filterBooksByTitle(title: String) -> [BookViewModel] {
        return Book.byBookTitle(title: title).map(BookViewModel.init)
    }
    
    func filterBooksByAuthor(name: String) -> [BookViewModel] {
        return Book.byAuthorName(name: name).map(BookViewModel.init)
    }
    
    func filterBooksByMinimumReviewCount(minimumReviewCount: Int = 0) -> [BookViewModel] {
        return Book.byMinimumReviewCount(minimumReviewCount: minimumReviewCount).map(BookViewModel.init)
    }
}
