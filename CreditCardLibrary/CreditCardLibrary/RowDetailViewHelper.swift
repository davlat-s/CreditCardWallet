import SwiftUI

struct RowDetailViewHelper: View {
    var rowName: String
    var rowValue: String
    
    @Environment(ModelData.self) private var modelData
    var body: some View {
        HStack{
            Text(rowName)
            Spacer()
            Text(rowValue)
        }
        .padding(.horizontal)
    }
}

#Preview {
    RowDetailViewHelper(rowName: "Annual Fee", rowValue: "495")
        .environment(ModelData())
}
