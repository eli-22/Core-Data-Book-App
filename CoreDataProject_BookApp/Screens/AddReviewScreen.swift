//
//  AddReviewScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import SwiftUI

struct AddReviewScreen: View {
    
    @StateObject private var addReviewVM = AddReviewViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    let book: BookViewModel
    
    var body: some View {
        Form {
            TextField("Enter title", text: $addReviewVM.title)
            TextEditor(text: $addReviewVM.text)
            
            HStack {
                Spacer()
                Button("Save") {
                    // Need to pass in a book view model.
                    addReviewVM.addReviewForBook(vm: book)
                    presentationMode.wrappedValue.dismiss()
                    //Dismiss the model after adding review.
                }
                Spacer()
            }

        }
        .navigationTitle("Add Review")
        .embedInNavigationView()
    }
}

struct AddReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let book = BookViewModel(book: Book(context: CoreDataManager.shared.viewContext))
        
        AddReviewScreen(book: book)
    }
}

