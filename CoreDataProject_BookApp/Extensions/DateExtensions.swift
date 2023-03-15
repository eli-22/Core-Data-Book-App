//
//  DateExtensions.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import Foundation

extension Date {
    
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}
