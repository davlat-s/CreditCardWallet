import SwiftUI

struct CategoryClosedView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredcards.isEmpty {
            Text("No closed cards available")
        } else {
            ForEach(filteredcards) { creditcard in
                CardRowView(creditcard: creditcard)
            }
        }
    }
    
    var filteredcards: [CreditCard] {
        modelData.creditCardList.filter { $0.isClosed }
    }
}

#Preview {
    CategoryClosedView()
        .environment(ModelData())
}
