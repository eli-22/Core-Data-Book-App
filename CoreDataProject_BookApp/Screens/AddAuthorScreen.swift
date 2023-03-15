//
//  AddAuthorScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/30/22.
//

import SwiftUI

struct AddAuthorScreen: View {
    
    let book: BookViewModel
    
    @StateObject private var addAuthorVM = AddAuthorViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Author")
                        .font(.largeTitle)
                    Text(book.title)
                }.padding(.bottom, 50)
                TextField("Enter name", text: $addAuthorVM.name)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save") {
                        addAuthorVM.addAuthorToBook(bookId: book.bookId)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddAuthorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAuthorScreen(book: BookViewModel(book: Book(context: Book.viewContext)))
    }
}
