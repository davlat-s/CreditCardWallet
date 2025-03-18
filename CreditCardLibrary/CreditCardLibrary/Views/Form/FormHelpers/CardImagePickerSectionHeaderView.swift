import SwiftUI

struct CardImagePickerSectionHeaderView: View {
    
    @State var bankName: Dictionary<String, [CardArt]>.Keys.Element
    
    var body: some View {
        Text(bankName)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .font(.title)
    }
}
