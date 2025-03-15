import SwiftUI

struct StringCustomTextField: View {
    var title: String
    @Binding var text: String
    var width : CGFloat
    var color : Color = .white
    var prompt : String = "Optional"
    var borderColor : Color = .white
    var variable : Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CustomTextView(text: title, color: color)
            TextField("", text: $text, prompt: Text(prompt))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(text.isEmpty && variable ? borderColor : Color.white, lineWidth: 0.5)
                        .disableAutocorrection(true)
                        .frame(height: .infinity)

                )
        }
        .frame(width: width, height: 55)
    }
}
