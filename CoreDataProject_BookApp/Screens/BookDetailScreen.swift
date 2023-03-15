//
//  BookDetailScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import SwiftUI

enum BookDetailsRoutes: Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case reviews
    case authors
}

extension BookDetailsRoutes {
    
    var displayText: String {
        switch self {
            case .reviews:
                return "Reviews"
            case .authors:
                return "Authors"
        }
    }
}

struct BookDetailScreen: View {
    
    let book: BookViewModel
    
    var body: some View {
        VStack {
            List {
                NavigationLink(
                    destination: ReviewListScreen(book: book),
                    label: {
                        Text("Reviews")
                    })
                
                NavigationLink(
                    destination: AuthorListScreen(book: book),
                    label: {
                        Text("Authors")
                    })
                
            }.listStyle(PlainListStyle())
        }.navigationTitle(book.title)
    }
}

struct BookDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        BookDetailScreen(book: BookViewModel(book: Book(context: CoreDataManager.shared.viewContext)))
            .embedInNavigationView()
    }
}
