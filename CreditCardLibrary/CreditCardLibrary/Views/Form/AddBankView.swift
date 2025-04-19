import SwiftUI

struct AddBankView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bankName: String = ""
    
    var onSave: (Bank) -> Void
    
    var body: some View {
        Form {
            CustomTextField(title: "Bank Name", text: $bankName, width: .infinity, prompt: "Charles Schwab", borderColor: .accent)
                .accessibilityIdentifier("AddBankView.bankNameTextField")
                .accessibilityLabel("Bank Name")
            
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Bank") {
                    let newBank = Bank(name: bankName)
                    
                    onSave(newBank)
                    bankName = ""
                    dismiss()
                }
                .accessibilityIdentifier("AddBankView.addBankButton")
                .accessibilityLabel("Add Bank")
                .disabled(bankName.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityIdentifier("AddBankView.cancelButton")
                .accessibilityLabel("Cancel")
            }
        }
        .formStyle(.grouped)
        .padding()
        .frame(width: 500)
    }
}
