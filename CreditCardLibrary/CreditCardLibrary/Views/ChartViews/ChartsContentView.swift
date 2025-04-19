import SwiftUI
import SwiftData
import Charts

struct ChartsContentView: View {
    
    @Query(sort: \CreditCard.openDate) private var cards: [CreditCard]
    @Query(sort: \Bank.name) private var banks: [Bank]
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 375, maximum: 650), spacing: 50)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                BarChartView {
                    CreditLimitBreakdownChart(cards: cards)
                }
                .accessibilityIdentifier("ChartsContentView.creditLimitBreakdownChart")
                .accessibilityLabel("Credit Limit Breakdown Chart")
                
                BarChartView {
                    CreditAgeChartView(cards: cards)
                }
                .accessibilityIdentifier("ChartsContentView.creditAgeChart")
                .accessibilityLabel("Credit Age Chart")
                
                PieChartView {
                    BankBreakdownChart(banks: banks)
                }
                .accessibilityIdentifier("ChartsContentView.bankBreakdownChart")
                .accessibilityLabel("Bank Breakdown Chart")
            }
            .padding()
        }
    }
}
