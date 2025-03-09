import SwiftUI

struct CustomPickerView<T: Hashable>: View {
    var title: String
    var options: [Bank]
    @Binding var selection: T
    var width: CGFloat
    var textColor: Color = .primary
    var borderColor: Color = .gray
    @State var tapped: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Picker(title, selection: $selection) {
                Text(title)
                    .tag(Optional<Bank>(nil))
                ForEach(options) { bank in
                    Text(bank.name).tag(Optional(bank))
                }
            }
            .frame(width: .infinity)
            .labelsHidden()
            .pickerStyle(.menu)
        }
    }
}
