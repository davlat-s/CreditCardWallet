import SwiftUI
import Charts

struct Charts: View {
    
    @Environment(ModelData.self) private var modelData
    var body: some View {
        GroupBox("Test"){
            Text("Credit Limits by Card")
            Chart(modelData.creditCardList) {card in
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
    }
}

#Preview {
    Charts()
        .environment(ModelData())
}
