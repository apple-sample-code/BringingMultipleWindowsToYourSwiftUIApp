/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A button to update the reading progress for a given book.
*/

import SwiftUI

struct UpdateReadingProgressButton: View {
    @ObservedObject var currentlyReading: CurrentlyReading
    @Binding var progressEditor: ProgressEditorModel
    
    init(
        book currentlyReading: CurrentlyReading,
        progressEditor: Binding<ProgressEditorModel>
    ) {
        self.currentlyReading = currentlyReading
        _progressEditor = progressEditor
    }
    
    var body: some View {
        Button {
            progressEditor.togglePresentation(for: currentlyReading)
        } label: {
            Label("Update Progress", systemImage: "bookmark")
        }
        .help("Update your reading progress for the book.")
        .disabled(currentlyReading.isFinished)
        .progressEditorModal(book: currentlyReading, model: $progressEditor)
    }
}

struct UpdateReadingProgressButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ProgressEditorModel.mocks, id: \.self) { editor in
                UpdateReadingProgressButton(
                    book: .mock,
                    progressEditor: .constant(editor))
            }
        }
    }
}
