import SwiftUI

struct AddClosedView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var closedReason: String = ""
    @Binding var textFieldWidth: CGFloat

    var onSave: (Closed) -> Void
    
    var body: some View {
        Form {
            TextField("Closed Reason", text: $closedReason)
                .frame(width:textFieldWidth)
            Button("Close Card") {
                let newReason = Closed(reason: closedReason)
                
                onSave(newReason)
                closedReason = ""
            }
        }
    }
}

#Preview {
    AddBankView(textFieldWidth: .constant(236), onSave: { bank in print(bank.name)})
        .modelContainer(PreviewData.shared.modelContainer)
}
