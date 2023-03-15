//
//  ReviewViewModel.swift
//  CoreDataProject
//
//  Created by Elise on 11/29/22.
//

import Foundation
import CoreData

struct ReviewViewModel {
    
    let review: Review
    
    var reviewId: NSManagedObjectID {
        return review.objectID
    }
    
    var title: String {
        return review.title ?? ""
    }
    
    var text: String {
        return review.text ?? ""
    }
    
    var publishedDate: Date? {
        return review.postedOn
    }
    
}
