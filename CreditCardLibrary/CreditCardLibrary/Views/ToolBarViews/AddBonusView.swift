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
    @State private var startDate: Date = .now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*30*3)
    
    var onSave: (Bonus) -> Void
    
    var body: some View {
        Form {
            TextField("Bonus Details", text: $bonusName, axis: .vertical)
                .frame(width:textFieldWidth)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            Button("Add Bonus") {
                let newBonus = Bonus(details: bonusName)
                
                onSave(newBonus)
                bonusName = ""
            }
        }
    }
}

#Preview {
    AddBonusView(textFieldWidth: .constant(236), onSave: { bonus in print(bonus.details)})
        .modelContainer(PreviewData.shared.modelContainer)
}
