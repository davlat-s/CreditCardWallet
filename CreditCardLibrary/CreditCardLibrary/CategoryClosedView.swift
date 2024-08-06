import SwiftUI

struct CategoryClosedView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        CategoryFilterHelper(filter: {$0.isClosed}, emptymessage: "No closed cards available")
    }
}


#Preview {
    CategoryClosedView()
        .environment(ModelData())
}
