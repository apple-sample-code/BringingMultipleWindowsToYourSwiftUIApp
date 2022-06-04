/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book detail view displaying the book detail view and action buttons.
*/

import SwiftUI

struct BookDetail: View {
    var dataModel: ReadingListModel
    var bookId: Book.ID?

    var body: some View {
        // Workaround for a known issue where `NavigationSplitView` and
        // `NavigationStack` fail to update when their contents are conditional.
        // For more information, see the iOS 16 Release Notes and
        // macOS 13 Release Notes. (91311311)"
        ZStack {
            if let bookId = bookId, let book = dataModel[book: bookId] {
                BookDetailContent(dataModel: dataModel, book: book)
                    .navigationTitle(title(for: book))
            } else {
                Color.clear
            }
        }
        #if os(macOS)
        .frame(minWidth: 480, idealWidth: 480)
        #endif
    }
    
    func title(for currentlyReading: CurrentlyReading) -> String {
        currentlyReading.book.title
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        let bookId = CurrentlyReading.mock.id
        return Group {
            BookDetail(dataModel: dataModel, bookId: nil)
            BookDetail(dataModel: dataModel, bookId: bookId)
            BookDetail(dataModel: dataModel, bookId: nil)
                .environment(\.locale, .italian)
            BookDetail(dataModel: dataModel, bookId: bookId)
                .environment(\.locale, .italian)
        }
    }
}
