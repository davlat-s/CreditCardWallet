import SwiftUI
import SwiftData

struct CreditCardsTableView: View {
    @Query var creditCards: [CreditCard]
    
    var body: some View {
        Table(creditCards) {
            TableColumn("Name") { card in Text(card.cardName)}
            TableColumn("Bank") { card in
                Text(card.bankName)}
            TableColumn("Annual Fee") { card in
                Text(String(card.annualFee))}
            TableColumn("Has APR Promo") { card in
                Text(String(card.hasAPRPromotion))}
        }
        .overlay {
            if creditCards.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Credit Cards", systemImage: "creditcard.and.123")
                }, description: {
                    Text("Start by adding a credit card to your wallet.")
                })
                .offset(y: -60)
            }
        }
    }
}

#Preview {
    CreditCardsTableView()
}
