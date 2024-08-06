import SwiftUI

struct CardImageView: View {
    @Environment(ModelData.self) private var modelData
    var image: Image
    var body: some View {
        image
            .resizable()
            .frame(width: 250, height: 150)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 13, height: 5)))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding()
    }
}

#Preview {
    CardImageView(image: Image("5"))
        .environment(ModelData())
}
