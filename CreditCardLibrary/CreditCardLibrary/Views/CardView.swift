import SwiftUI


struct CardView: View {
    @Bindable var creditCard: CreditCard
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
        
    var body: some View {
        let w: CGFloat = 486
        let h: CGFloat = 306
        
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
                            .frame(width: w/9, height: w/10)
                        Spacer()
                       
                    }
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
        .padding(20)
    }
}

#Preview {
    CardView(creditCard: SampleData.shared.creditCard)
}
