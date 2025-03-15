import SwiftUI
import Charts

struct CreditLimitChartView: View {
    var cards: [CreditCard]
    
    var filteredCards: [CreditCard] {
        cards.filter { $0.creditLimit ?? 0 > 0 }
    }
    
    var totalCreditLimit: Double {
        filteredCards.reduce(0) { $0 + ($1.creditLimit ?? 0) }
    }
    
    var averageCreditLimit: Double {
        let total = filteredCards.reduce(0) { $0 + ($1.creditLimit ?? 0) }
        return filteredCards.isEmpty ? 0 : total / Double(filteredCards.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text ("Credit limits of all open cards")
            Text("Total: $\(totalCreditLimit.formatted(.number.precision(.fractionLength(0))))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                ForEach(Array(filteredCards.enumerated()), id: \.offset) { index, card in
                    BarMark(
                        x: .value("Card", index),
                        y: .value("Credit Limit", card.creditLimit ?? 0)
                    )
                    .foregroundStyle(Color.pink.gradient)
                    .cornerRadius(10)
                    
                    RuleMark(y: .value("Average", averageCreditLimit))
                        .foregroundStyle(Color.blue)
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                }
            }
            .padding(.vertical)
            .chartXAxis {
                AxisMarks { mark in
                }
            }
            .chartYAxis {
                AxisMarks { mark in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
        }
    }
}

//#Preview {
//    CreditLimitChartView(cards: [])
//}
