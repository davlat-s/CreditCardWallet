import SwiftUI
import Charts
import SwiftData

struct Charts: View {
    @Query var creditCards: [CreditCard]
    
    var body: some View {
        ScrollView {
            GroupBox("Limit"){
                Text("Credit Limits by Card")
                Chart(creditCards) {card in
                         BarMark(
                             x: .value("Name", String(card.id)),
                             y: .value("Credit Limit", card.creditLimit),
                             width: .ratio(0.6)
                             
                         )
                     }
                    .padding()
                    .foregroundColor(.green)
                    .frame(height: 150)
                    .chartXAxis(.hidden)
                
            }
//            GroupBox("Age"){
//                        Text("Credit Age by Card")
//                        Chart(creditCards){
//                            card in BarMark(x: .value("card", String(card.id)), y: .value("age", card.age))
//                        }
//                        .padding()
//                        .foregroundColor(.purple)
//                        .frame(height: 150)
//                        .chartXAxis(.hidden)
//            }
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
    Charts()
}
