import SwiftUI

struct CategoryBusinessView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filter: {$0.isBusiness && !$0.isClosed}, emptymessage: "No active business cards available")
    }
}

#Preview {
    CategoryBusinessView()
        .environment(ModelData())
}
