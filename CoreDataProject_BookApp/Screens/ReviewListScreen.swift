//
//  ReviewListScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import SwiftUI

struct ReviewListScreen: View {
    
    let book: BookViewModel
    @State private var isPresented: Bool = false
    @StateObject private var reviewListVM = ReviewListViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Reviews")) {
                    ForEach(reviewListVM.reviews, id: \.reviewId) { review in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(review.title)
                                Text(review.text)
                                    .font(.caption)
                            }
                            Spacer()
                            Text(review.publishedDate!.asFormattedString())
                        }
                    }
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarItems(trailing: Button("Add New Review") {
            isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            reviewListVM.getReviewsByBook(vm: book)
        }, content: {
            AddReviewScreen(book: book)
        })
        .onAppear(perform: {
            reviewListVM.getReviewsByBook(vm: book)
        })
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let book = BookViewModel(book: Book(context: CoreDataManager.shared.viewContext))
        ReviewListScreen(book: book).embedInNavigationView()
    }
}

