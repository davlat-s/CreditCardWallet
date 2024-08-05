import SwiftUI

struct CategoryAllView: View {
    @Environment(ModelData.self) private var modelData
        
    var body: some View {
        List(modelData.creditCardList) {creditcard in CardRowView(creditcard: creditcard)
        }
    }
}

#Preview {
    CategoryAllView()
        .environment(ModelData())
}
