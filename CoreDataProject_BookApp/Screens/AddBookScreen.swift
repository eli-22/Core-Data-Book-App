//
//  AddBookScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import SwiftUI

struct AddBookScreen: View {
    
    @StateObject private var addBookVM = AddBookViewModel()
    // @StateObject captures any event that might occur so we can redraw the interface.
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Enter title", text: $addBookVM.title)
            TextField("Enter publisher", text: $addBookVM.publisher)
            HStack {
                Text("Rating")
                Spacer()
                RatingView(rating: $addBookVM.rating)
            }
            DatePicker("Publication Date", selection: $addBookVM.publicationDate)
            
            HStack {
                Spacer()
                Button("Save") {
                    addBookVM.save()
                    presentationMode.wrappedValue.dismiss()
                    // After saving, dismiss the model. 
                }
                Spacer()
            }
            
        }
        .navigationTitle("Add Book")
        .embedInNavigationView()
    }
}

struct AddBookScreen_Previews:
    PreviewProvider {
    static var previews: some View {
        AddBookScreen()
    }
}
