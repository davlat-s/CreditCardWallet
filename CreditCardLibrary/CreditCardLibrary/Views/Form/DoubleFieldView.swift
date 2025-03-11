import SwiftUI

struct DoubleFieldView: View {
    var title: String
    @Binding var text: Double
    var width: CGFloat
    var color: Color = .white
    var prompt: String = "Optional"
    var borderColor: Color = .white
    var variable: Bool = true

    @State private var userInput: String = "" // Track user input

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            CustomTextView(text: title, color: color)
            TextField("", text: Binding(
                get: { userInput.isEmpty ? String(text) : userInput },
                set: { newValue in
                    userInput = newValue
                    if let value = Double(newValue) {
                        text = value
                    }
                }
            ), prompt: Text(prompt))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(userInput.isEmpty && variable ? borderColor : Color.white, lineWidth: 0.5)
            )
        }
        .frame(width: width, height: 55)
    }
}
