import SwiftUI

struct AddPromotionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var promoName: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*30*12)
    
    var onSave: (Promotion) -> Void
    
    var body: some View {
        Form {
            CustomTextField(title: "Promotion Details", text: $promoName, width: .infinity, prompt: "0% APR for 12 months on purchases and balance transfers", borderColor: .accent)
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Promotion") {
                    let newPromo = Promotion(details: promoName)
                    
                    onSave(newPromo)
                    promoName = ""
                    dismiss()
                }
                .disabled(promoName.isEmpty)
            }
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .frame(width: 500)
        
    }
}


