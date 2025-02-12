import SwiftUI


struct CardView: View {
    @Bindable var creditCard: CreditCard
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
    
    var body: some View {
        let w = 400.00
        let h = (w / 8.56) * 5.389
        
        return ZStack{
            Image(creditCard.cardArt?.assetID ?? "default")
                .resizable()
                .interpolation(.low)
                .aspectRatio(contentMode: .fit)
                .frame(width: w, height: h)
                .clipShape(.rect(cornerRadius: 15))

                
        }
    }
}

#Preview {
    CardView(creditCard: PreviewData.shared.creditCard)
}
