//
//  AuthorListScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import SwiftUI

// 1. Create an instance of Author List View Model.
// 2. Call getAuthorsByBook in onAppear, pass the view model instance.
// 3. We don't want multiple IDs for the same author, so we add/select authors based on their name instead. (Not practical in a real app, will have to use ID and prevent author duplication.)

struct AuthorListScreen: View {
    
    @State private var isPresented: Bool = false
    @StateObject private var authorListVM = AuthorListViewModel()
    
    let book: BookViewModel
    
    var body: some View {
           
            List {
            
                Section(header: Text("Authors")) {
                    ForEach(authorListVM.authors, id: \.authorId) { author in
                        
                        HStack {
                            NavigationLink(
                                destination: AuthorDetailsScreen(author: author),
                                label: {
                                    Text(author.name)
                                        .foregroundColor(.black)
                                })
                            Spacer()
                        }
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    }
                }
            
            }.listStyle(PlainListStyle())
            
        
        .onAppear(perform: {
            authorListVM.getAuthorsByBook(vm: book)
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            authorListVM.getAuthorsByBook(vm: book)
            // Make sure updates show immediately.
        }, content: {
            AddAuthorScreen(book: book)
        })
            .navigationTitle(book.title)
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))

    }
}

struct AuthorListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
       let book = Book(context: CoreDataManager.shared.viewContext)
        return AuthorListScreen(book: BookViewModel(book: book))
            .embedInNavigationView()
    }
}
