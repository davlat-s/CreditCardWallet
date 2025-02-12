//
//  DetailPanelView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 2/3/25.
//

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
                    .frame(height: 400)
            }
            
            ShowHistoryView(isShowingHistory: $isShowingHistory)
        }
    }
}

#Preview {
    DetailPanelView(creditCard: PreviewData.shared.creditCard)
}
