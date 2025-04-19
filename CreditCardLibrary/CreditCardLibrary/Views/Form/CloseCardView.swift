import SwiftUI

struct CloseCardView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var closedReason: String = ""
    
    var onSave: (Closed) -> Void
    
    var body: some View {
        Form {
            CustomTextField(title: "Closed Reason", text: $closedReason, width: .infinity, prompt: "Did not want to pay the annual fee")
                .accessibilityIdentifier("CloseCardView.closedReasonTextField")
                .accessibilityLabel("Closed Reason")
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
                .accessibilityIdentifier("CloseCardView.closeCardButton")
                .accessibilityLabel("Close Card")
                
            }
            ToolbarItem(placement: .cancellationAction){
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityIdentifier("CloseCardView.cancelButton")
                .accessibilityLabel("Cancel")
            }
        }
        .formStyle(.grouped)
        .frame(width: 500)
    }
}
