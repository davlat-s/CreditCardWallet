import SwiftUI

struct SelectCardImageView: View {
    @Binding var cardArt: CardArt?
    @Binding var isShowingImagePicker: Bool
    
    var body: some View {
        let h = 175.0
        let w = h * (8.56 / 5.389)
        
        
        HStack {
            Spacer()
            Button(action: {
                isShowingImagePicker.toggle()
            }) {
                Group {
                    if let cardArt = cardArt {
                        Image(cardArt.assetID)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(height: h)
                    } else {
                        
                        Color.black.opacity(0.02)
                            .frame(width: w, height: h)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundColor(.gray)
                        
                            .overlay(alignment: .center, content: {
                                Text("Select Card Image")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                    .frame(width: w, height: h)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        )
                    }
                }
            }
            .shadow(color: .black.opacity(0.1), radius: 5)
            .buttonStyle(BouncyDarkenButtonStyle())
            Spacer()
        }
        .frame(width: w, height:200)
    }
}

struct BouncyDarkenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
}
