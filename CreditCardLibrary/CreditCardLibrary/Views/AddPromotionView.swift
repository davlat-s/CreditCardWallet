import SwiftUI

struct AddPromotionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var promoName: String = ""
    
    var onSave: (Promotion) -> Void
    
    var body: some View {
        Form {
            TextField("Promotion Name", text: $promoName)
            Button("Add Promotion") {
                let newPromo = Promotion(name: promoName)
                
                onSave(newPromo)
                promoName = ""
            }
        }
    }
}

#Preview {
    AddPromotionView(onSave: { promo in print(promo.name)})
        .modelContainer(SampleData.shared.modelContainer)
}
