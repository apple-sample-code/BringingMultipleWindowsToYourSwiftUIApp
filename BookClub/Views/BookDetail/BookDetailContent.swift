/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book detail view displaying the book metadata, as well as the user's
 reading progress and entry notes.
*/

import SwiftUI

struct BookDetailContent: View {
    var dataModel: ReadingListModel
    @ObservedObject var book: CurrentlyReading
    @State private var progressEditor = ProgressEditorModel()
    #if os(iOS)
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    #endif
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                BookDetailHeader(
                    dataModel: dataModel,
                    book: book,
                    progressEditor: $progressEditor)
                Divider()
                BookDetailReadingHistory(progress: book.progress)
            }
            .scenePadding(scenePadding)
        }
        .frame(minWidth: 350, minHeight: 350)
        .background(BookDetailBackground())
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                FavoriteButton(dataModel: dataModel, bookId: book.id)
                ShareButton(dataModel: dataModel, bookId: book.id)
            }
            ToolbarItemGroup(placement: toolbarItemPlacement) {
                Group {
                    UpdateReadingProgressButton(
                        book: book,
                        progressEditor: $progressEditor)
                    MarkAsFinishedButton(book: book)
                }
                .labelStyle(.iconOnly)
            }
        }
    }
    
    var scenePadding: Edge.Set {
        #if os(macOS)
        .all
        #else
        isCompactVerticalSizeClass ? .all : [.horizontal, .bottom]
        #endif
    }
    
    var isCompactVerticalSizeClass: Bool {
        #if os(iOS)
        return verticalSizeClass == .compact
        #else
        return false
        #endif
    }
    
    var toolbarItemPlacement: ToolbarItemPlacement {
        #if os(iOS)
        return .bottomBar
        #else
        return .secondaryAction
        #endif
    }
}

struct BookDetailContent_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        return Group {
            BookDetailContent(dataModel: dataModel, book: .mock)
            BookDetailContent(dataModel: dataModel, book: .mock)
                .environment(\.locale, .italian)
        }
    }
}
