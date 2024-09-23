//
//  AddBonusView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 9/15/24.
//

import SwiftUI

struct AddBonusView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var textFieldWidth: CGFloat
    @State private var bonusName: String = ""
    
    var onSave: (Bonus) -> Void
    
    var body: some View {
        Form {
            TextField("Bonus Name", text: $bonusName, axis: .vertical)
                .frame(width:textFieldWidth)
            Button("Add Bonus") {
                let newBonus = Bonus(name: bonusName)
                
                onSave(newBonus)
                bonusName = ""
            }
        }
    }
}

#Preview {
    AddBonusView(textFieldWidth: .constant(236), onSave: { bonus in print(bonus.name)})
        .modelContainer(PreviewData.shared.modelContainer)
}
