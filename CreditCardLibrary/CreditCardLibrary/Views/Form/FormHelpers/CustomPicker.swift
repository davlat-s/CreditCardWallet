import SwiftUI

struct CustomPicker: View {
    var title: String
    var options: [Bank]
    @Binding var selection: Bank?
    @Binding var isNewBank: Bool
    var width: CGFloat
    var textColor: Color = .primary
    var borderColor: Color = .gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            CustomText(text: "Bank")
            
            HStack {
                Spacer()
                Picker(title, selection: $selection) {
                    Text(title)
                        .tag(Optional<Bank>(nil))
                    ForEach(options) { bank in
                        Text(bank.name).tag(Optional(bank))
                    }
                }
                .frame(height: 35)
                .frame(width: .infinity)
                .labelsHidden()
                .pickerStyle(.menu)
                Button {
                    isNewBank.toggle()
                }label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(selection != nil ? Color.white : borderColor, lineWidth: 0.5)
                    .frame(height: .infinity)
                
                    .disableAutocorrection(true)
            )
        }
        .frame(width: width, height: 55)
        
    }
}
