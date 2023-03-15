//
//  ShowFilterScreen.swift
//  CoreDataProject
//
//  Created by Elise on 12/4/22.
//

import SwiftUI

struct ShowFilterScreen: View {
    @State private var publicationDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var bookTitle: String = ""
    @State private var authorName: String = ""
    @State private var minimumReviewCount: String = ""
    
    @Binding var books: [BookViewModel]
    // Use binding expression to reflect filters in the view that passed in the values (the book list screen).
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var filterVM = FilterViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by publication date")) {
                TextField("Enter publication date:", text: $publicationDate)
                HStack {
                    Spacer()
                    Button("Search"){
                        
                        if let pubDate = publicationDate.asDate() {
                            books =
                            // bindable expression, so book list screen will also be updated if this changes.
                            filterVM.filterBooksByPublicationDate(publicationDate: pubDate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range")) {
                TextField("Enter start date:", text: $startDate)
                TextField("Enter end date:", text: $endDate)
                HStack {
                    Spacer()
                    Button("Search"){
                        
                        guard let lowerBoundDate = startDate.asDate(),
                              let upperBoundDate = endDate.asDate() else {
                            return
                        }
                        
                        books = filterVM.filterBooksByDateRange(lowerBoundDate: lowerBoundDate, upperBoundDate: upperBoundDate)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating")) {
                TextField("Enter start date:", text: $startDate)
                TextField("Enter end date:", text: $endDate)
                TextField("Enter minimum rating", text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search"){
                        
                        let lowerBoundDate = startDate.asDate()
                        let upperBoundDate = endDate.asDate()
                        let minRating = Int(minimumRating)
                        
                        books = filterVM.filterBooksByDateRangeOrMinimumRating(lowerBoundDate: lowerBoundDate, upperBoundDate: upperBoundDate, minimumRating: minRating)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by book title/title begins with:")) {
                TextField("Enter book title:", text: $bookTitle)
                HStack {
                    Spacer()
                    Button("Search"){
                        
                        books = filterVM.filterBooksByTitle(title: bookTitle)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by author name")) {
                TextField("Enter author name:", text: $authorName)
                HStack {
                    Spacer()
                    Button("Search"){
                        
                        books = filterVM.filterBooksByAuthor(name: authorName)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section (header: Text("Search by minimum review count")) {
                TextField("Enter minimum review count: ", text:$minimumReviewCount)
                HStack {
                    Spacer ()
                    Button ("Search") {
                        
                        let minReviewCount = Int(minimumReviewCount)
                        if !minimumReviewCount.isEmpty {
                            books = filterVM.filterBooksByMinimumReviewCount(minimumReviewCount: minReviewCount ?? 0)
                        }
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle (PlainButtonStyle())
                    Spacer ()
                }
            }
        }
        .navigationTitle("Filters")
        .embedInNavigationView()
        
    }
}

struct ShowFilterScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowFilterScreen(books: .constant([BookViewModel(book: Book())]))
    }
}
