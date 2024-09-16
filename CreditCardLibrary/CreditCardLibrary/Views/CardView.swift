import SwiftUI


struct CardView: View {
        
    var body: some View {
        
        let w: CGFloat = 486
        let h: CGFloat = 306
        
        return ZStack{
            Color(.gray).cornerRadius(16)
            
            HStack {
                VStack(alignment:.leading) {
                    HStack {
                        Text("Credit card name")
                            .font(.custom("Courier", size: w/15))

                    }
                    HStack {
                        Image("chip")
                            .resizable()
                            .frame(width: w/9, height: w/10)
                        Spacer()
                        Image("centurion")
                            .resizable()
                            .frame(width: w/3, height: w/3)
                        Spacer()
                    }
                    Text("6543 775466 67422")
                        .font(.custom("Courier", size: w/13))
                    HStack {
                        Text("Card Holder name")
                            .font(.custom("Courier", size: w/25))
                        Spacer()
                        Image("amex")
                            .resizable()
                            .frame(width: w/10, height: w/15)
                        
                    }
                    
                }
                .padding(3)
                Spacer()
            }
            .padding(20)
        }
        .frame(width: w, height: h)
        .padding(20)
    }
}

#Preview {
    CardView()
}
