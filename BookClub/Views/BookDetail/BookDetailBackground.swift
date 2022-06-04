/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Book detail background view.
*/

import SwiftUI

struct BookDetailBackground: View {
    var cornerRadius: CGFloat? = nil
    
    var body: some View {
        shape
            .fill(BackgroundStyle())
            .ignoresSafeArea()
    }
    
    var shape: some Shape {
        if let cornerRadius = cornerRadius, cornerRadius > 0 {
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            return AnyShape(Rectangle())
        }
    }
}

struct BookDetailBackground_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailBackground()
    }
}
