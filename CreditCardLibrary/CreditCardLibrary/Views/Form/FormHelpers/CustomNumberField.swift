import SwiftUI

struct CustomNumberField: View {
    var title: String
    @Binding var number: Double?
    var width : CGFloat
    var color : Color = .white
    var prompt : String = "Optional"
    var borderColor : Color = .white
    var variable : Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CustomText(text: title, color: color)
            TextField("", value: $number, format: .number, prompt: Text(prompt))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(number == nil && variable ? borderColor : Color.white, lineWidth: 0.5)
                        .disableAutocorrection(true)
                        .frame(height: .infinity)
                    
                )
        }
        .frame(width: width, height: 55)
    }
}


