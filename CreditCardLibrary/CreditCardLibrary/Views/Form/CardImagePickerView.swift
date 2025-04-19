import SwiftUI
import SwiftData

struct CardImagePickerView: View {
    @Binding var selectedCardArt: CardArt?
    
    @Environment(\.dismiss) var dismiss
    
    @Query var cardArts: [CardArt]
    
    var groupedCardArts: [String: [CardArt]] {
        let sortedCardArts = cardArts.sorted { $0.bankName < $1.bankName }
        return Dictionary(grouping: sortedCardArts, by: { $0.bankName })
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedCardArts.keys.sorted(), id: \.self) { bankName in
                    Section {
                        LazyVGrid(columns: columns) {
                            ForEach(groupedCardArts[bankName] ?? [], id: \.assetID) { cardArt in
                                Image(cardArt.assetID)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                                    .padding(.vertical, 5)
                                    .clipShape(.rect(cornerRadius: 12))
                                    .accessibilityIdentifier("CardImagePickerView.cardArt.\(cardArt.assetID)")
                                    .accessibilityLabel("Select card art \(cardArt.assetID) for \(bankName)")
                                    .onTapGesture {
                                        selectedCardArt = cardArt
                                        dismiss()
                                    }
                            }
                        }
                    } header: {
                        CardImagePickerSectionHeaderView(bankName: bankName)
                    }
                }
            }
            .accessibilityIdentifier("CardImagePickerView.cardArtList")
            .accessibilityLabel("Card Art List")
            .navigationTitle("Select Card Art")
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel"){
                    dismiss()
                }
                .accessibilityIdentifier("CardImagePickerView.cancelButton")
                .accessibilityLabel("Cancel")
            }
        }
    }
}
