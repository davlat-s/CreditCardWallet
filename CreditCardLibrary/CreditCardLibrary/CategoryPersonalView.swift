import SwiftUI

struct CategoryPersonalView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filter: {!$0.isBusiness && !$0.isClosed}, emptymessage: "No active personal cards available")
    }
}

#Preview {
    CategoryPersonalView()
        .environment(ModelData())
}
