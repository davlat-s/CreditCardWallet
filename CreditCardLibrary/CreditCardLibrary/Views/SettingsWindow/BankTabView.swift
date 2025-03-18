import SwiftUI
import SwiftData


struct BankTabView: View {
    
    @State var selectedBank: Bank? = nil
    @State var bankToDelete: Bank? = nil
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Bank.name, order: .forward)]) var existingBanks: [Bank]
    
    var body: some View {
        List(selection: $selectedBank) {
            ForEach(existingBanks) {bank in
                HStack{
                    Text(bank.name)
                        .frame(height: 25)
                    Spacer()
                    if selectedBank == bank {
                        Button(action: {
                            if let selected = selectedBank {
                                bankToDelete = selected
                            }
                        }) {
                            Label("Delete", systemImage: "trash")
                                .imageScale(.large)
                                .labelStyle(.iconOnly)
                        }
                        .disabled(selectedBank == nil)
                        .buttonStyle(.plain)
                        
                    }
                }
                .tag(bank)
            }
        }
        .clipShape(.rect(cornerRadius: 10))
        .alert(item: $bankToDelete) { bank in
            Alert(
                title: Text("Delete Bank"),
                message: Text("Are you sure you want to delete \(bank.name)?"),
                primaryButton: .destructive(Text("Delete")) {
                    delete(bank)
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func delete(_ bank: Bank) {
        modelContext.delete(bank)
        selectedBank = nil
        try? modelContext.save()
    }
}
