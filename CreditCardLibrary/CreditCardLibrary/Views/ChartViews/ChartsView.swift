import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {
    
    @Query(sort: \CreditCard.openDate) private var cards: [CreditCard]

    var body: some View {
        VStack{
            StyledChartCellView {
                CreditLimitChartView(cards: cards)
            }
            StyledChartCellView {
                CreditAgeChartView()
            }
        }
    }
}

#Preview {
    ChartsView()
}
