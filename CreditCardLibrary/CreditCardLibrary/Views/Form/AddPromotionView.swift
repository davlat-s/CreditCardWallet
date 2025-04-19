import SwiftUI

struct AddPromotionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var promoDescription: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*30*12)
    
    var onSave: (Promotion) -> Void
    
    var body: some View {
        Form {
            CustomTextField(title: "Promotion Details", text: $promoDescription, width: .infinity, prompt: "0% APR for 12 months on purchases and balance transfers", borderColor: .accent)
                .accessibilityIdentifier("AddPromotionView.promoDescriptionTextField")
                .accessibilityLabel("Promotion Details")
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .accessibilityIdentifier("AddPromotionView.startDatePicker")
                .accessibilityLabel("Promotion Start Date")
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .accessibilityIdentifier("AddPromotionView.endDatePicker")
                .accessibilityLabel("Promotion End Date")
            
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Promotion") {
                    let newPromo = Promotion(details: promoDescription, startDate: startDate, endDate: endDate)
                    
                    onSave(newPromo)
                    dismiss()
                }
                .disabled(promoDescription.isEmpty)
                .accessibilityIdentifier("AddPromotionView.addPromotionButton")
                .accessibilityLabel("Add Promotion")
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityIdentifier("AddPromotionView.cancelButton")
                .accessibilityLabel("Cancel")
            }
        }
        .frame(width: 500)
        
    }
}
