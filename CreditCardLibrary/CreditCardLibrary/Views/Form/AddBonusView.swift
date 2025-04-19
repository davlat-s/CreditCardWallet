import SwiftUI

struct AddBonusView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var bonusName: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = Date.now.addingTimeInterval(60*60*24*30*3)
    
    var onSave: (Bonus) -> Void
    
    var body: some View {
        
        Form {
            CustomTextField(title: "Bonus Details", text: $bonusName, width: .infinity, prompt: "$200 cash back after spending $1,000 in the first 3 months")
                .accessibilityLabel("Bonus Details")
                .accessibilityIdentifier("bonusDetailsTextField")
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .accessibilityLabel("Start Date")
                .accessibilityIdentifier("startDatePicker")
            
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .accessibilityLabel("End Date")
                .accessibilityIdentifier("endDatePicker")
        }
        .padding()
        .formStyle(.grouped)
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Add Bonus") {
                    let newBonus = Bonus(details: bonusName, startDate: startDate, endDate: endDate)
                    
                    onSave(newBonus)
                    dismiss()
                }
                .accessibilityLabel("Add Bonus")
                .accessibilityIdentifier("addBonusButton")
                .disabled(bonusName.isEmpty)
                
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .accessibilityLabel("Cancel")
                .accessibilityIdentifier("cancelButton")
                
            }
        }
        .frame(width: 500)
    }
    
}
