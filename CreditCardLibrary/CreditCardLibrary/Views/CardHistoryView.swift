import SwiftUI

struct CardHistoryView: View {
    @Bindable var creditCard: CreditCard

    var body: some View {
            VStack {
                HStack {
                    if creditCard.history.isEmpty {
                        Text("No history available")
                            .font(.body)
                            .padding(.vertical, 2)
                    } else {
                        List {
                            ForEach(creditCard.history, id: \.self) { entry in
                                Text("\(entry)")
                            }
                            .onDelete(perform: deleteHistory)
                        }
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .frame(minHeight: 100)
    }

    
    // Delete function
    private func deleteHistory(at offsets: IndexSet) {
        creditCard.history.remove(atOffsets: offsets)
    }
}

#Preview {
    CardHistoryView(creditCard: PreviewData.shared.creditCard)
}
