import SwiftUI
import Charts

struct BankBreakdownChart: View {
    
    var banks: [Bank]
    
    var filteredBanks: [Bank] {
        banks.filter { !$0.creditCards.isEmpty }
    }
    
    // Define an array of colors
    let colors: [Color] = [.red, .blue, .green, .orange, .indigo]
    
    // Total open cards count (only cards where 'closed' is nil)
    var totalCardCount: Int {
        filteredBanks.reduce(0) { $0 + $1.creditCards.filter { $0.closed == nil }.count }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Open credit cards by bank")
            Text("Total cards: \(totalCardCount)")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            Chart {
                // Enumerate filtered banks to use the index for color mapping
                ForEach(Array(filteredBanks.enumerated()), id: \.element.id) { index, bank in
                    let openCount = bank.creditCards.filter { $0.closed == nil }.count
                    SectorMark(
                        angle: .value("Cards", openCount),
                        innerRadius: .ratio(0.618),
                        angularInset: 3
                    )
                    .foregroundStyle(colors[index % colors.count]).opacity(0.95)
                    .cornerRadius(6)
                    .annotation(position: .overlay, content: {
                        Text(bank.name)
                            .foregroundStyle(.primary)
                    })
                }
            }
            .chartLegend(.hidden)
            .padding(.vertical)
        }
    }
}
