import SwiftUI


struct CardView: View {
    @Bindable var creditCard: CreditCard
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
        
    var body: some View {
        let w = CreditCard.cardWidth
        let h = CreditCard.cardHeight
        
        return ZStack{
            Color(creditCard.color ?? .gray)
                .cornerRadius(16)
            HStack {
                VStack(alignment:.leading) {
                    HStack {
                        Text(creditCard.bank?.name ?? "")
                            .font(.custom("Courier", size: w/15))

                    }
                    HStack {
                        Text(creditCard.name)
                            .font(.custom("Courier", size: w/20))

                    }
                    HStack {
                        Image("chip")
                            .resizable()
                            .frame(width: w/7, height: w/10)
                        Spacer()
                       
                    }
                    .padding(.top)
                    .padding(.bottom)
                    Text("***** ****** \(creditCard.lastDigits)")
                        .font(.custom("Courier", size: w/13))
                    HStack {
                        Text(creditCard.isBusiness ? "Business" : "Personal")
                            .font(.custom("Courier", size: w/25))
                        Spacer()
                        Image(creditCard.paymentProcessor?.logo ?? "amexLogo")
                            .resizable()
                            .frame(width: w/7, height: w/8)
                        
                    }
                    
                }
                .padding(3)
                Spacer()
            }
            .padding(20)
        }
        .frame(width: w, height: h)
    }
}

#Preview {
    CardView(creditCard: PreviewData.shared.creditCard)
}
