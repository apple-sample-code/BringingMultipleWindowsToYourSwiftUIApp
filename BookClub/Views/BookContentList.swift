/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book content list view showing filtered book results for a given category
 or search query.
*/

import SwiftUI

struct BookContentList: View {
    @ObservedObject var dataModel: ReadingListModel
    @ObservedObject var navigationModel: NavigationModel
    @Environment(\.isSearching) private var isSearching
    private var searchText: String
    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif
    
    init(
        searchText: String,
        dataModel: ReadingListModel,
        navigationModel: NavigationModel
    ) {
        self.searchText = searchText
        self.dataModel = dataModel
        self.navigationModel = navigationModel
    }
    
    var body: some View {
        // Workaround for a known issue where `NavigationSplitView` and
        // `NavigationStack` fail to update when their contents are conditional.
        // For more information, see the iOS 16 Release Notes and
        // macOS 13 Release Notes. (91311311)"
        ZStack {
            if let category = navigationModel.selectedCategory {
                let items = dataModel.items(for: category, matching: searchText)
                List(selection: $navigationModel.selectedBookId) {
                    ForEach(items) { currentlyReading in
                        NavigationLink(value: currentlyReading.id) {
                            BookCard(
                                book: currentlyReading.book,
                                progress: currentlyReading.currentProgress,
                                isSelected: isSelected(for: currentlyReading.id))
                            .contextMenu {
                                BookContextMenu(
                                    dataModel: dataModel,
                                    bookId: currentlyReading.book.id)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationTitle(category.title)
                #if os(macOS)
                .contextAction(forSelectionType: Book.ID.self) { books in
                    books.forEach { openWindow(value: $0) }
                }
                .frame(minWidth: 240, idealWidth: 240)
                .navigationSubtitle(subtitle(for: items.count))
                #endif
            }
        }
        .onDisappear {
            if navigationModel.selectedBookId == nil {
                navigationModel.selectedCategory = nil
            }
        }
    }
    
    func isSelected(for bookID: Book.ID) -> Bool {
        navigationModel.selectedBookId == bookID
    }
    
    #if os(macOS)
    func subtitle(for count: Int) -> String {
        if isSearching {
            return "Found \(count) results"
        } else {
            return count == 1 ? "\(count) Item" : "\(count) Items"
        }
    }
    #endif
}

struct BookContentList_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        let navigationModel = NavigationModel()
        return Group {
            BookContentList(
                searchText: "",
                dataModel: dataModel,
                navigationModel: navigationModel)
            
            BookContentList(
                searchText: "Jane",
                dataModel: dataModel,
                navigationModel: navigationModel)
            
            BookContentList(
                searchText: "",
                dataModel: dataModel,
                navigationModel: navigationModel)
                .environment(\.locale, .italian)
            
            BookContentList(
                searchText: "Jane",
                dataModel: dataModel,
                navigationModel: navigationModel)
                .environment(\.locale, .italian)
        }
    }
}
