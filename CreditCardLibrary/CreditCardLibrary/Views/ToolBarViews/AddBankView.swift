import SwiftUI

struct AddBankView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bankName: String = ""
    @Binding var textFieldWidth: CGFloat

    var onSave: (Bank) -> Void
    
    var body: some View {
        Form {
            TextField("Bank Name", text: $bankName)
                .frame(width:textFieldWidth)
            Button("Add Bank") {
                let newBank = Bank(name: bankName)
                
                onSave(newBank)
                bankName = ""
            }
        }
    }
}

#Preview {
    AddBankView(textFieldWidth: .constant(236), onSave: { bank in print(bank.name)})
        .modelContainer(PreviewData.shared.modelContainer)
}
