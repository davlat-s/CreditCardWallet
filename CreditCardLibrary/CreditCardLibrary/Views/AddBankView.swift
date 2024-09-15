import SwiftUI

struct AddBankView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bankName: String = ""
    var onSave: (Bank) -> Void
    
    var body: some View {
        Form {
            TextField("Bank Name", text: $bankName)
            Button("Save Bank") {
                let newBank = Bank(name: bankName)
            
                onSave(newBank)
            }
        }
    }
}

#Preview {
    AddBankView(onSave: { bank in print(bank.name)})
        .modelContainer(SampleData.shared.modelContainer)
}
