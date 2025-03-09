import SwiftUI

struct AddBankView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bankName: String = ""
    @Binding var textFieldWidth: CGFloat

    var onSave: (Bank) -> Void
    
    var body: some View {
        Form {
            RequiredTextField(title: "Bank Name", text: $bankName, width: .infinity, prompt: "Charles Schwab")

        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Bank") {
                    let newBank = Bank(name: bankName)
                    
                    onSave(newBank)
                    bankName = ""
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .formStyle(.grouped)
        .padding()
        .frame(width: 500)
    }
}

#Preview {
    AddBankView(textFieldWidth: .constant(236), onSave: { bank in print(bank.name)})
        .modelContainer(PreviewData.shared.modelContainer)
}
