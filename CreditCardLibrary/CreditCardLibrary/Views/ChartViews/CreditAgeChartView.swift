import SwiftUI
import Charts


struct CreditAgeChartView: View {
    var cards: [CreditCard]
    
    // Filter cards that are not closed and not business.
    var filteredCards: [CreditCard] {
        cards.filter { $0.closed == nil && !$0.isBusiness }
    }
    
    // Compute the total credit age (in years) for the filtered cards.
    var totalCreditAge: Double {
        filteredCards.reduce(0.0) { sum, card in
            let ageInSeconds = Date().timeIntervalSince(card.openDate)
            let ageInYears = ageInSeconds / (365.25 * 24 * 3600)
            return sum + ageInYears
        }
    }
    
    // Compute the average credit age.
    var averageCreditAge: Double {
        filteredCards.isEmpty ? 0 : totalCreditAge / Double(filteredCards.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text ("Credit age of personal cards")
            Text("Average: \(averageCreditAge.formatted(.number.precision(.fractionLength(1)))) years")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            Chart {
                ForEach(Array(filteredCards.enumerated()), id: \.offset) { index, card in
                    BarMark(
                        x: .value("Card", index),
                        y: .value("Card Age", Date().timeIntervalSince(card.openDate) / (365.25 * 24 * 3600))
                    )
                    .foregroundStyle(Color.purple.gradient)
                    .cornerRadius(10)
                    
                    RuleMark(y: .value("Average", averageCreditAge))
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
//    CreditAgeChartView()
//}
