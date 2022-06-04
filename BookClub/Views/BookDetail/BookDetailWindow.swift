/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book detail view, which opens in its own presented window, displaying the
 book metadata, current reading progress,
 and notes.
*/

import SwiftUI

struct BookDetailWindow: View {
    @ObservedObject var dataModel: ReadingListModel
    @Binding var bookId: Book.ID?

    var body: some View {
        Group {
            if let bookId = bookId, let book = dataModel[book: bookId] {
                BookDetailContent(dataModel: dataModel, book: book)
            } else {
                Color.clear
            }
        }
        .toolbar {
            FavoriteButton(dataModel: dataModel, bookId: bookId)
            ShareButton(dataModel: dataModel, bookId: bookId)
        }
    }
}

struct BookDetailWindow_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        let bookId = CurrentlyReading.mock.id
        return Group {
            BookDetailWindow(dataModel: dataModel, bookId: .constant(bookId))
            BookDetailWindow(dataModel: dataModel, bookId: .constant(bookId))
                .environment(\.locale, .italian)
        }
    }
}
