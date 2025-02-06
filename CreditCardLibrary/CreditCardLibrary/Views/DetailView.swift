import SwiftUI

struct DetailView: View {
    
    @Bindable var creditCard: CreditCard
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    init(creditCard: CreditCard) {
        self.creditCard = creditCard
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(creditCard: creditCard)
                    .frame(width: 486/2, height: 306/2)
                    .scaleEffect(0.6)
                    .padding(40)
                
                Section("Card Details"){
                    HStack{
                        Spacer()
                        VStack{
                            HStack {
                                Text("CardName")
                                Spacer()
                                Text(creditCard.name)
                            }
                            HStack {
                                Text("Type")
                                Spacer()
                                Text(creditCard.isBusiness ? "Business" : "Personal")
                            }
                            if !creditCard.isChargeCard {
                                HStack {
                                    Text("Credit Limit")
                                    Spacer()
                                    Text(creditCard.creditLimit)
                                }
                            }
                            
                            HStack {
                                Text("Charge Card")
                                Spacer()
                                Text(creditCard.isChargeCard ? "Yes" : "No")
                            }
                            if creditCard.bank != nil {
                                HStack {
                                    Text("Bank Name")
                                    Spacer()
                                    Text(creditCard.bank?.name ?? "Bank is not specified")
                                }
                            }
                            
                            Section("Promotions"){
                                if creditCard.promotion != nil{
                                    HStack {
                                        Text("Promotion Details")
                                        Spacer()
                                        Text(creditCard.promotion?.details ?? "None")
                                    }
                                    HStack {
                                        Text("Start Date")
                                        Spacer()
                                        Text(creditCard.promotion?.startDate?.description ?? "None")
                                    }
                                    HStack {
                                        Text("End Date")
                                        Spacer()
                                        Text(creditCard.promotion?.endDate?.description ?? "None")
                                    }
                                } else {
                                    HStack{
                                        Text("No promotions available")
                                        Spacer()
                                    }
                                }
                            }
                           
                            
                            Section("Bonuses"){
                                if creditCard.bonus != nil{
                                    HStack {
                                        Text("Bonus Details")
                                        Spacer()
                                        Text(creditCard.bonus?.details ?? "Bonus details not specified")
                                    }
                                    HStack {
                                        Text("Start Date")
                                        Spacer()
                                        Text(creditCard.bonus?.startDate?.description ?? "None")
                                    }
                                    HStack {
                                        Text("End Date")
                                        Spacer()
                                        Text(creditCard.bonus?.endDate?.description ?? "None")
                                    }
                                }else {
                                    HStack{
                                        Text("No bonuses available")
                                        Spacer()
                                    }
                                }
                            }
                            
                            if creditCard.closed != nil{
                                HStack {
                                    Text("Closed Reason")
                                    Spacer()
                                    Text(creditCard.closed?.reason ?? "Reason not specified")
                                }
                            }
                        }
                        Spacer()
                    }
                
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Credit Card Details")
        }
    }
}

// MARK: Previews

#Preview("Details") {
    DetailView(creditCard: PreviewData.shared.creditCard)
        .modelContainer(PreviewData.shared.modelContainer)
}

