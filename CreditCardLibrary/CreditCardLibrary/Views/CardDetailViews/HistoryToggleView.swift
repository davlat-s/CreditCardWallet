import SwiftUI
import os

struct HistoryToggleView: View {
    @Binding var isShowingHistory: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                Log.action.info("User clicked \(isShowingHistory ? "Hide History" : "Show History") button")
                isShowingHistory.toggle()
            }, label: {
                Text(isShowingHistory ? "Hide History" : "Show History")
            })
            .padding()
            .accessibilityIdentifier(String(isShowingHistory ? "hideHistory" : "showHistory"))
            .accessibilityLabel(Text(isShowingHistory ? "Hide History" : "Show History"))
        }
        .frame(height: 35)
    }
    
}
