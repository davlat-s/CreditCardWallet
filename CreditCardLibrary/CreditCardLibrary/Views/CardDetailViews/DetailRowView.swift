import SwiftUI


// TODO: Turn this into a modifier

struct DetailRowView: View {
    
    var label: String
    var value: String
    
    var body: some View {
        HStack{
            Text(label)
            Spacer()
            Text(value)
        }
        .padding()
        .frame(minWidth: 200, idealWidth: 400, alignment: .center)
        
        
    }
}

