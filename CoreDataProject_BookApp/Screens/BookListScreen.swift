//
//  BookListScreen.swift
//  CoreDataProject
//
//  Created by Elise on 11/21/22.
//

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addBook
    case showFilters
}

struct BookListScreen: View {
    
    @StateObject private var bookListVM = BookListViewModel()
    //@StateObject property wrapper ensures the instance doesn't get destroyed when the view updates. Used when you need to create a reference type inside one of your views and make sure it stays alive for use in that view and others you share it with.
    
    @State private var activeSheet: Sheets?
    
    private func deleteBook(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let book = bookListVM.books[index] // We are only deleting a single book.
            bookListVM.deleteBook(book: book)
            bookListVM.getAllBooks()
        }
    }
    
    private func getAllBooks() {
        if !bookListVM.filterEnabled {
            bookListVM.getAllBooks()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset") {
                    bookListVM.getAllBooks()
                }.padding()
                Button("Sort") {
                    bookListVM.sortEnabled = true
                }
                Spacer()
                VStack(spacing: 10) {
                    Button("Filter") {
                        bookListVM.filterEnabled = true
                        activeSheet = .showFilters
                    }
                }
            }.padding(.trailing, 40)
                .background(Color(#colorLiteral(red: 0.202427417, green: 0.5955722928, blue: 0.8584871888, alpha: 1)))
                .foregroundColor(.white)
            
            List {
                
                ForEach(bookListVM.books, id: \.bookId) { book in
                    NavigationLink(
                        destination: BookDetailScreen(book: book),
                        label: {
                            BookCell(book: book)
                        })
                }.onDelete(perform: deleteBook)
                
            }.listStyle(PlainListStyle())
            
                .navigationTitle("Books")
                .navigationBarItems(trailing: Button("Add Book") {
                    activeSheet = .addBook
                })
                .sheet(item: $activeSheet, onDismiss: {
                    getAllBooks()
                    // Refreshes the list after book added.
                }, content: { item in
                    switch item {
                    case .addBook:
                        AddBookScreen()
                    case .showFilters:
                        ShowFilterScreen(books: $bookListVM.books)
                        // Because it's a bindable expression, the parent view will also be refreshed if we change the array of books passed to the filter screen.
                    }
                })
                .onAppear(perform: {
                    getAllBooks()
                })
            
            if bookListVM.sortEnabled {
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            
                            //  Picker view has bookListVM.selectedSortOption and selectedSortDirection. When we select something from the picker view, the BookListViewModel has already populated these properties from the picker view, so we don't have to pass the selection to a sort function.
                            
                            Picker("Select title", selection: $bookListVM.selectedSortOption) {
                                ForEach(SortOptions.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                                .clipped()
                            
                            Picker("Sort Direction", selection: $bookListVM.selectedSortDirection) {
                                ForEach(SortDirection.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                                .clipped()
                            
                            Spacer()
                        }
                        Button("Done") {
                            bookListVM.sortEnabled = false
                            bookListVM.sort()
                            // We don't have to pass anything to this function because selectedSortOption and selectedSortDirection are binding properties, so the values are populated when they are selected.
                        }
                    }
                }
            }
        }.embedInNavigationView()
    }
}

struct BookListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookListScreen()
        }
    }
}

struct BookCell: View {
    
    let book: BookViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(book.title)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Text(book.publisher)
                    .font(.callout)
                    .opacity(0.5)
                Text(book.publicationDate ?? "")
                    .font(.callout)
                    .opacity(0.8)
                Spacer()
                
            }
            Spacer()
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(book.rating!)")
            }
        }
        .padding()
        .foregroundColor(Color.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
    }
}

