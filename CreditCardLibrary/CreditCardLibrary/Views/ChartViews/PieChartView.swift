import SwiftUI


// TODO: Turn this into a modifier

struct PieChartView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(width: 350, height: 400, alignment: .center)
            .padding()
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}
