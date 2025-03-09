import SwiftUI

struct StyledPieCharCellView<Content: View>: View {
    let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
                .frame(width: 400, height: 400, alignment: .center)
                .padding()
                .cornerRadius(12)
                .shadow(radius: 5)
        }
}

//#Preview {
//    StyledPieCharCellView()
//}
