//
//  ShowLogsView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 2/4/25.
//

import SwiftUI

struct ShowHistoryView: View {
    @Binding var isShowingHistory: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isShowingHistory.toggle()
            }, label: {
                Text(isShowingHistory ? "Hide History" : "Show History")
            })
            .padding()
        }
        .frame(height: 35)
    }
    
}

#Preview {
    ShowHistoryView(isShowingHistory: .constant(true))
}
