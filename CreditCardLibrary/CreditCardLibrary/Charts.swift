import SwiftUI
import Charts

struct Charts: View {
    
    @Environment(ModelData.self) private var modelData
    var body: some View {
        ScrollView {
            GroupBox("Limit"){
                Text("Credit Limits by Card")
                Chart(modelData.creditCardListSortedOldest) {card in
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
            GroupBox("Age"){
                        Text("Credit Age by Card")
                        Chart(modelData.creditCardListSortedOldest){
                            card in BarMark(x: .value("card", String(card.id)), y: .value("age", card.age))
                        }
                        .padding()
                        .foregroundColor(.purple)
                        .frame(height: 150)
                        .chartXAxis(.hidden)
            }
        }
    }
}

#Preview {
    Charts()
        .environment(ModelData())
}
