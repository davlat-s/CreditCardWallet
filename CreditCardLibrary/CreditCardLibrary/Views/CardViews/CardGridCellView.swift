import SwiftUI

struct CardGridCellView: View {
    let creditCard: CreditCard
    
    var body: some View {
        let w = 250.00
        let h = (w / 8.56) * 5.389
    
        VStack(alignment: .center, spacing: 8) {
            Image(creditCard.cardArt?.assetID ?? "default")
                .resizable()
                .interpolation(.low)
                .aspectRatio(contentMode: .fit)
                .frame(width: w, height: h)
                .clipShape(.rect(cornerRadius: 8))
            Text(creditCard.name)
                .font(.headline)
                .lineLimit(1)
            Text("Opened \(creditCard.openDate, style: .relative) ago")
                .font(.caption)
                .foregroundColor(.secondary)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
    }
}
#Preview {
    CardGridCellView(creditCard: CreditCard(name: "test", creditLimit: "2000", openDate: Date.now, isBusiness: false, isChargeCard: false, lastDigits: "3523", history: [""], paymentProcessor: PaymentProcessor.amex, cardArt: CardArt(assetID: "American_Express-Business-Plum")))
        .modelContainer(PreviewData.shared.modelContainer)

}
