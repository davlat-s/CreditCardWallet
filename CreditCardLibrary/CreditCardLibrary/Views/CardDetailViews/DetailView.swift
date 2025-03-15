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
                    .padding()
                    .shadow(color: Color.black.opacity(0.1), radius: 25)
                
                GroupBox {
                        VStack{
                            
                            DetailRowView(label: "Card Name", value: creditCard.name)
                            DetailRowView(label: "Type", value: creditCard.isBusiness ? "Business" : "Personal")
                            
                            if let limit = creditCard.creditLimit {
                                DetailRowView(label: "Credit Limit", value: String(limit))
                            }
                            
                            DetailRowView(label: "Charge Card", value: creditCard.isChargeCard ? "Yes" : "No")
                            
                            if creditCard.bank != nil {
                                DetailRowView(label: "Bank Name", value: creditCard.bank?.name ?? "Bank is not specified")
                            }
                            
                            if creditCard.closed != nil {
                                DetailRowView(label: "Closed Reson", value: creditCard.closed?.reason ?? "Reason not specified")
                            }
                        }
                } label: {
                    Label("Card Details", systemImage: "creditcard")
                        .font(.headline)
                }
                .groupBoxStyle(ModernGroupBoxStyle())
                .padding(.horizontal)
                
                
                if !creditCard.bonuses.isEmpty {
                    GroupBox {
                        ForEach(creditCard.bonuses, id: \.self) { bonus in
                            VStack{
                                DetailRowView(label: "Bonus Details", value: bonus.details)
                                DetailRowView(label: "Start Date", value: bonus.startDate?.description ?? "None")
                                DetailRowView(label: "End Date", value: bonus.endDate?.description ?? "None")
                            }
                        }
                        
                        
                    } label: {
                        Label("Bonus", systemImage: "dollarsign.square")
                            .font(.headline)

                    }
                    .groupBoxStyle(ModernGroupBoxStyle())
                                    .padding(.horizontal)
                }
                
                if !creditCard.promotions.isEmpty {
                    GroupBox {
                        ForEach(creditCard.promotions, id: \.self) { promo in
                                VStack{
                                    DetailRowView(label: "Promotion Details", value: promo.details)
                                    DetailRowView(label: "Start Date", value: promo.startDate?.description ?? "None")
                                    DetailRowView(label: "End Date", value: promo.endDate?.description ?? "None")
                                }
                        }
                        
                        
                    } label: {
                        Label("Promotion", systemImage: "percent")
                            .font(.headline)

                    }
                    .groupBoxStyle(ModernGroupBoxStyle())
                    .padding(.horizontal)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Credit Card Details")

    }
}

struct ModernGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            configuration.label
            configuration.content
                .background(Color.grayDetailRow.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.grayDetailRow.opacity(0.8)))
        }
        .padding()
        .background(Color(.background))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5)

    }
}
// MARK: Previews

#Preview("Details") {
    DetailView(creditCard: PreviewData.shared.creditCard)
        .modelContainer(PreviewData.shared.modelContainer)
}

