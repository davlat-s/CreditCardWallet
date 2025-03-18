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
                            ForEach(creditCard.history, id: \.self) { history in
                                Text("\(history.date, style: .date)  \(history.entry)")
                                    .font(.custom(
                                            "Menlo",
                                            fixedSize: 18))
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .frame(minHeight: 100)
    }
}

#Preview {
    CardHistoryView(creditCard: PreviewData.shared.creditCard)
}
