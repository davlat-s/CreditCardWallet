import SwiftUI
import SwiftData

struct CardImagePickerView: View {
    /// The selected CardArt is passed back via this binding.
    @Binding var selectedCardArt: CardArt?
    
    /// Environment dismissal to close the sheet when a selection is made.
    @Environment(\.dismiss) var dismiss
    
    @Query var cardArts: [CardArt]  // No sort descriptor here

    // Grouping after sorting in memory
    var groupedCardArts: [String: [CardArt]] {
        let sortedCardArts = cardArts.sorted { $0.bankName < $1.bankName }
        return Dictionary(grouping: sortedCardArts, by: { $0.bankName })
    }
    
    /// Define a grid layout with three columns.
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // Iterate over sorted bank names.
                ForEach(groupedCardArts.keys.sorted(), id: \.self) { bankName in
                    Section(header: Text(bankName)) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(groupedCardArts[bankName] ?? [], id: \.assetID) { cardArt in
                                Image(cardArt.assetID)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                                    .padding(2)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .onTapGesture {
                                        // Update the selection and dismiss.
                                        selectedCardArt = cardArt
                                        dismiss()
                                    }
                            }
                        }
                        .padding(.vertical, 3)
                    }
                }
            }
            .navigationTitle("Select Card Art")
        }
        .toolbar {
            ToolbarItem{
                Button("Cancel"){
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CardImagePickerView(selectedCardArt: .constant(nil))
        .modelContainer(PreviewData.shared.modelContainer)
}
