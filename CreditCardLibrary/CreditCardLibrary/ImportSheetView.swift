import SwiftUI
import SwiftData
import AppKit

// Presents a sheet allowing the user to select which cards from the manifest to import
struct ImportSheetView: View {
    @EnvironmentObject var documentManager: DocumentManager
    @Environment(\.modelContext) private var context: ModelContext
    @Environment(\.dismiss) private var dismiss

    // Track selections by card ID
    @State private var selections: [String: Bool] = [:]

    var body: some View {
        NavigationView {
            List {
                ForEach(documentManager.cards) { card in
                    Toggle(isOn: Binding(
                        get: { selections[card.id] ?? false },
                        set: { selections[card.id] = $0 }
                    )) {
                        HStack {
                            if let pkgURL = documentManager.packageURL {
                                let imageURL = pkgURL
                                    .appendingPathComponent(card.cardFolder)
                                    .appendingPathComponent(card.backgroundFilename75)
                                if let nsImage = NSImage(contentsOf: imageURL) {
                                    Image(nsImage: nsImage)
                                        .clipped()
                                        .cornerRadius(4)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(card.description)
                                    .font(.headline)
                                Text("••\(card.primaryAccountSuffix)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Import Wallet Cards")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Import") {  }
                        .disabled(selectedIDs.isEmpty)
                }
            }
        }
    }

    // IDs of cards user marked for import
    private var selectedIDs: [String] {
        selections.filter { $0.value }.map { $0.key }
    }

    }
