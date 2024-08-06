import SwiftUI

struct CategoryClosedView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        if filteredCreditCards.isEmpty {
            Text("No closed cards available")
        } else {
            CategoryViewHelper(filteredCreditCards: filteredCreditCards)
            }
        }
    var filteredCreditCards: [CreditCard] {
        modelData.creditCardList.filter { $0.isClosed }
    }
    }
    

#Preview {
    CategoryClosedView()
        .environment(ModelData())
}
