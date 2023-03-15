//
//  Book+Extensions.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import Foundation
import CoreData

extension Book: BaseModel { 
    
    static func byPublicationDate(publicationDate: Date) -> [Book] {
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@", #keyPath(Book.publicationDate), publicationDate as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // Next step (for every function) is to call this function from inside the filter view. For now it is contained in the model.
    
    static func byDateRange(lower: Date, upper: Date) -> [Book] {
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                        #keyPath(Book.publicationDate), lower as NSDate,
                                        #keyPath(Book.publicationDate), upper as NSDate)
        // Will be checked in order. So it will check the keypath (the book's publication date) to see if it's greater than or equal to the lower date bound and then check to see if it's less than or equal to the upper date bound.
        
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    static func byDateRangeOrMinimumRating(lowerBound: Date?, upperBound: Date?, minimumRating: Int?) -> [Book] {
        
        var predicates: [NSPredicate] = []
        // We need to use either the dateRangePredicate OR the minRatingPredicate.
        
        if let lower = lowerBound, let upper = upperBound {
            
            let dateRagePredicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                                #keyPath(Book.publicationDate), lower as NSDate,
                                                #keyPath(Book.publicationDate), upper as NSDate)
            predicates.append(dateRagePredicate)
            
        } else if let minRating = minimumRating {
            let minRatingPredicate = NSPredicate(format: "%K >= %i",
                                                 #keyPath(Book.rating), minRating)
            // %@ can be used for strings and dates. To pass a number, we must use %i.
            // (Rating is a double, but we present it as a whole number, so we can use %i.)
            
            predicates.append(minRatingPredicate)
        }
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        // A compound predicate can perform logical queries with AND or OR.
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    static func byBookTitle(title: String) -> [Book] {
        
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Book.title), title)
        // [cd]:
        //  c = "case-insensitive"
        //  d = "diacritic-insensitive" (Letter "é" will be included in search for "e.")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    static func byAuthorName(name: String) -> [Book] {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        // Commented out to change to a keypath approach
        // request.predicate = NSPredicate(format: "authors.name CONTAINS %@", name)
        
        // Keypath approach #1. %K.property
        // request.predicate = NSPredicate(format: "%K.name CONTAINS %@", #keyPath(Book.authors), name)
        
        // Keypath approach #2. %K.%K (two keypaths)
        request.predicate = NSPredicate(format: "%K.%K CONTAINS %@", #keyPath(Book.authors), #keyPath(Author.name), name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    static func byMinimumReviewCount(minimumReviewCount: Int = 1) -> [Book] {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        // request.predicate = NSPredicate(format: "reviews.@count >= %i", minimumReviewCount)
        request.predicate = NSPredicate(format: "%K.@count >= %i", #keyPath(Book.reviews), minimumReviewCount)
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
}
