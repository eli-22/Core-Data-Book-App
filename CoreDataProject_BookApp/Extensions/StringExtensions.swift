//
//  StringExtensions.swift
//  CoreDataProject
//
//  Created by Elise on 12/4/22.
//

import Foundation

// Allows us to change a string to a date.

extension String {
    
    func asDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self)
    }
    
}
