import SwiftUI

struct CustomDatePicker: View {
    
    var title: String
    @Binding var selection: Date
    var width : CGFloat
    var color : Color = .white
    var startDate: Date = .distantPast
    var endDate: Date = .now
    var borderColor : Color = .gray
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            CustomText(text: title)
            DatePicker(title, selection: $selection, 
                       in: startDate...endDate, 
                       displayedComponents: .date
            )
            .labelsHidden()
            .datePickerStyle(.stepperField)
            .focusable(false)
            .focusEffectDisabled(true)
            .padding(.vertical, 5)
        }
        .padding(.trailing, 10)
    }
}

