import SwiftUI


struct CardImageView: View {
    @Bindable var creditCard: CreditCard
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
    
    var body: some View {
        let w = 300.00
        let h = (w / 8.56) * 5.389
        
        return ZStack{
            Image(creditCard.cardArt?.assetID ?? "default")
                .resizable()
                .interpolation(.low)
                .aspectRatio(contentMode: .fit)
                .frame(width: w, height: h)
                .clipShape(.rect(cornerRadius: 8))
            
            
        }
    }
}
