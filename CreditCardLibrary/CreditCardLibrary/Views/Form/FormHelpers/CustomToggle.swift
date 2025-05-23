import SwiftUI

struct CustomToggle: View {
    var title: String
    @Binding var isOn: Bool
    var width: CGFloat
    var textColor: Color = .white
    var borderColor: Color = .gray
    
    var body: some View {
        HStack {
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(.checkbox)
            CustomText(text: title)
                .frame(alignment: .leading)
        }
        .frame(width: width, height: 55, alignment: .leading)
    }
}

