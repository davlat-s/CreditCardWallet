import SwiftUI

struct CardRowView: View {
    @Environment(ModelData.self) private var modelData
    var creditcard: CreditCard
    
    var body: some View {
        HStack {
            creditcard.image
                .resizable()
                .frame(width: 65, height: 40)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 5)))
                
            Text(creditcard.cardName)
                .padding()
                .fixedSize(horizontal: true, vertical: true)
            
        }
        .frame(width: 300, alignment: .leading)
    }
}

#Preview {
    CardRowView(creditcard: ModelData().creditCardListSortedNewest[1])
        .environment(ModelData())
}
