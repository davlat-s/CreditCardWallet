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
            RequiredTextField(title: "Bonus Details", text: $bonusName, width: .infinity, prompt: "$200 cash back after spending $1,000 in the first 3 months")
            
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
         
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
        }
        .padding()
        .formStyle(.grouped)
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Bonus") {
                    let newBonus = Bonus(details: bonusName)
                    
                    onSave(newBonus)
                    bonusName = ""
                    dismiss()
                }
                .disabled(bonusName.isEmpty)

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

#Preview {
    AddBonusView(textFieldWidth: .constant(236), onSave: { bonus in print(bonus.details)})
        .modelContainer(PreviewData.shared.modelContainer)
}
