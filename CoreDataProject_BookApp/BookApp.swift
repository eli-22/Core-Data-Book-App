//
//  BookAppApp.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import SwiftUI

@main
struct BookApp: App {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some Scene {
        WindowGroup {
            BookListScreen()
        }
    }
}
