import SwiftUI

struct AddPromotionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var textFieldWidth: CGFloat
    @State private var promoName: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*30*12)
    
    var onSave: (Promotion) -> Void
    
    var body: some View {
        Form {
            TextField("Promotion Details", text: $promoName, axis: .vertical)
                .frame(width:textFieldWidth)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            Button("Add Promotion") {
                let newPromo = Promotion(details: promoName)
                
                onSave(newPromo)
                promoName = ""
                dismiss()
            }
            Button("Cancel") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    AddPromotionView(textFieldWidth: .constant(236), onSave: { promo in print(promo.details)})
        .modelContainer(PreviewData.shared.modelContainer)
}
