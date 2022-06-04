/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book context menu view when for quick actions.
*/

import SwiftUI

struct BookContextMenu: View {
    var dataModel: ReadingListModel
    var bookId: Book.ID
    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif

    var body: some View {
        if let book = dataModel[book: bookId] {
            #if os(macOS)
            Section {
                Button("Open in New Window") {
                    openWindow(value: book.id)
                }
            }
            #endif
            Section {
                Button("Mark as Finished") {
                    book.markProgress(1.0)
                }
                FavoriteButton(dataModel: dataModel, bookId: bookId)
                ShareButton(dataModel: dataModel, bookId: bookId)
            }
        }
    }
}

struct BookContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        let bookId = CurrentlyReading.mock.id
        return Group {
            BookContextMenu(dataModel: dataModel, bookId: bookId)
            BookContextMenu(dataModel: dataModel, bookId: bookId)
                .environment(\.locale, .italian)
        }
    }
}
