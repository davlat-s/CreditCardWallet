import SwiftUI

struct CardRowView: View {
    @State var creditCard: CreditCard
    var body: some View {
        HStack {
            Spacer()
            let w = 250.00
            let h = (w / 8.56) * 5.389
            VStack {
                Image("American_Express-Personal-Platinum_Schwab")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: w, height: h)
                    .drawingGroup()
                Text(creditCard.name)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    CardRowView(creditCard: (PreviewData.shared.creditCard))
}
