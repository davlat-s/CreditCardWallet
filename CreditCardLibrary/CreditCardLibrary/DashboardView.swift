import SwiftUI

struct DashboardView: View {
    
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        Charts()
    }
}

#Preview {
    DashboardView()
        .environment(ModelData())
}
