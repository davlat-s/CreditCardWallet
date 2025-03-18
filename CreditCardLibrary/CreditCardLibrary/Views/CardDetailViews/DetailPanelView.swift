import SwiftUI

struct DetailPanelView: View {
    
    @Bindable var creditCard: CreditCard
    @State private var isShowingHistory: Bool = false

    
    var body: some View {
        VSplitView {
            DetailView(creditCard: creditCard)
                .scrollIndicatorsFlash(onAppear: true)
            if isShowingHistory {
                CardHistoryView(creditCard: creditCard)
                    .frame(minHeight: 200, idealHeight:350, maxHeight: 500)
            }
            
            ToggleHistoryView(isShowingHistory: $isShowingHistory)
        }
    }
}

#Preview {
    DetailPanelView(creditCard: PreviewData.shared.creditCard)
}
