import SwiftUI


// TODO: Turn this into a modifier

struct BarChartView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(width: 350, height: 300, alignment: .center)
            .padding()
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}

