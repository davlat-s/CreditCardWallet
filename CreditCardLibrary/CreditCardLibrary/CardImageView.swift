import SwiftUI

struct CardImageView: View {

    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 337, height: 212.5)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 13, height: 5)))
            .shadow(radius: 31.8)
            .padding()
    }
}

#Preview {
    CardImageView(image: Image("5"))
}
