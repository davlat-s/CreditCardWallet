import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {
    
    @Query(sort: \CreditCard.openDate) private var cards: [CreditCard]
    
    // Define adaptive grid columns
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 400, maximum: 450), spacing: 50)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 5) {
                StyledChartCellView {
                    CreditLimitChartView(cards: cards)
                }
                StyledChartCellView {
                    CreditAgeChartView(cards: cards)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ChartsView()
}
