import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {
    
    @Query(sort: \CreditCard.openDate) private var cards: [CreditCard]
    @Query(sort: \Bank.name) private var banks: [Bank]
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 375, maximum: 650), spacing: 50)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                StyledBarChartCellView {
                    CreditLimitChartView(cards: cards)
                }
                StyledBarChartCellView {
                    CreditAgeChartView(cards: cards)
                }
                StyledPieCharCellView {
                    BankPieChartView(banks: banks)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChartsView()
}
