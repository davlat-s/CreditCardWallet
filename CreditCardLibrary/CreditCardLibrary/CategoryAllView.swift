import SwiftUI

struct CategoryAllView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filter: {!$0.isClosed}, emptymessage: "No active cards available")
    }
}

#Preview {
    CategoryAllView()
        .environment(ModelData())
}
