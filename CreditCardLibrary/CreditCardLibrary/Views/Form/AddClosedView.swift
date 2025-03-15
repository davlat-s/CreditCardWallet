import SwiftUI

struct AddClosedView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var closedReason: String = ""

    var onSave: (Closed) -> Void
    
    var body: some View {
        Form {
            StringCustomTextField(title: "Closed Reason", text: $closedReason, width: .infinity, prompt: "Did not want to pay the annual fee")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Close Card") {
                    let newReason = Closed(reason: closedReason)
                    
                    onSave(newReason)
                    closedReason = ""
                    dismiss()
                }
                .disabled(closedReason.isEmpty)

            }
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .formStyle(.grouped)
        
        .frame(width: 500)
    }
}


