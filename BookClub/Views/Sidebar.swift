/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Sidebar view displaying a list of book categories.
*/

import SwiftUI

struct Sidebar: View {
    var searchText: String
    var dataModel: ReadingListModel
    @ObservedObject var navigationModel: NavigationModel
    @State private var selectedBookId: Book.ID?

    var body: some View {
        List(selection: $navigationModel.selectedCategory) {
            ForEach(dataModel.categories) { category in
                NavigationLink(value: category) {
                    Label(category.title, systemImage: category.iconName)
                }
            }
        }
        .navigationTitle("Categories")
        .onChange(of: navigationModel.selectedBookId) { bookId in
            selectedBookId = bookId
        }
        .onChange(of: searchText) {
            navigationModel.selectedBookId = $0.isEmpty ? selectedBookId : nil
        }
        .onChange(of: navigationModel.selectedCategory) { _ in
            navigationModel.selectedBookId = nil
        }
        #if os(macOS)
        .frame(minWidth: 200, idealWidth: 200)
        #endif
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = ReadingListModel()
        let navigationModel = NavigationModel()
        return Group {
            Sidebar(
                searchText: "",
                dataModel: dataModel,
                navigationModel: navigationModel)
            
            Sidebar(
                searchText: "Jane",
                dataModel: dataModel,
                navigationModel: navigationModel)
            
            Sidebar(
                searchText: "",
                dataModel: dataModel,
                navigationModel: navigationModel)
            .environment(\.locale, .italian)
            
            Sidebar(
                searchText: "Jane",
                dataModel: dataModel,
                navigationModel: navigationModel)
            .environment(\.locale, .italian)
        }
    }
}
