import SwiftUI

struct SelectCardView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Select a card")
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
                .fixedSize()
            Spacer()
        }
    }
}

#Preview {
    SelectCardView()
}
