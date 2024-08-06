import SwiftUI

struct CreditCardsTableView: View {
    @Environment(ModelData.self) private var modelData

    var body: some View {
        Table(modelData.creditCardList) {
            TableColumn("Name") { card in Text(card.cardName)}
            TableColumn("Bank") { card in
                Text(card.bankName)}
            TableColumn("Annual Fee") { card in
                Text(String(card.annualFee))}
            TableColumn("Open Date") { card in
                Text(card.openDate)}
            TableColumn("Has APR Promo") { card in
                Text(String(card.hasAPRPromotion))}
        }
    }
}

#Preview {
    CreditCardsTableView()
        .environment(ModelData())
}
