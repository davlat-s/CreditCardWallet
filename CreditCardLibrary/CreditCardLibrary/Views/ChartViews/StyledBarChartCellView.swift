import SwiftUI

struct StyledBarChartCellView<Content: View>: View {
    let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
                .frame(width: 400, height: 300, alignment: .center)
                .padding()
                .cornerRadius(12)
                .shadow(radius: 5)
        }
}

#Preview {
    StyledBarChartCellView{Text("Hello")}
}
