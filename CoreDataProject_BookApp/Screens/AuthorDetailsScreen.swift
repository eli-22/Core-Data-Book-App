//
//  AuthorDetailsScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import SwiftUI

struct AuthorDetailsScreen: View {
    
    let author: AuthorViewModel
    
    var body: some View {
        VStack {
            // author.books is an array of Book View Models
            List(author.books, id: \.bookId) { book in
                BookCell(book: book)
            }.listStyle(PlainListStyle())
            
        }.navigationTitle(author.name)
    }
}

struct AuthorDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let authorVM = AuthorViewModel(author: Author(context: Author.viewContext))
        AuthorDetailsScreen(author: authorVM)
    }
}
