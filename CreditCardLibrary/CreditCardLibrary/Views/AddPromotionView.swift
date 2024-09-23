import SwiftUI

struct AddPromotionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var textFieldWidth: CGFloat
    @State private var promoName: String = ""
    
    var onSave: (Promotion) -> Void
    
    var body: some View {
        Form {
            TextField("Promotion Name", text: $promoName, axis: .vertical)
                .frame(width:textFieldWidth)

            Button("Add Promotion") {
                let newPromo = Promotion(name: promoName)
                
                onSave(newPromo)
                promoName = ""
            }
        }
    }
}

#Preview {
    AddPromotionView(textFieldWidth: .constant(236), onSave: { promo in print(promo.name)})
        .modelContainer(PreviewData.shared.modelContainer)
}
