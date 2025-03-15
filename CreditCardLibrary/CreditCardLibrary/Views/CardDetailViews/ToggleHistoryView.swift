import SwiftUI

struct ToggleHistoryView: View {
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
    ToggleHistoryView(isShowingHistory: .constant(true))
}
