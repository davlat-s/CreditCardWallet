import SwiftUI

struct CustomText: View {
    
    var text: String
    var color: Color = .white
    
    var body: some View {
        Text(text)
            .font(.callout)
            .foregroundColor(color)
    }
}
