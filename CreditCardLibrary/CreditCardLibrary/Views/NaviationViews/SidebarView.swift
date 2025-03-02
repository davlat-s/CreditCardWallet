import SwiftUI

struct SidebarView: View {
    @Binding var selectedCategory: SideBarCategories
    @AppStorage("isExpanded") private var isExpanded: Bool = false
    // TODO: make isExpanded persistent across user sessions.

    private func sortedCategories() -> [SideBarCategories] {
        let categories: [SideBarCategories] = [
            .business,
            .personal,
            .all,
            .closed
        ]
        return categories.sorted { $0.order < $1.order }
    }
    
    var body: some View {
        List(selection: $selectedCategory) {
            Section("Card Categories") {
                ForEach(sortedCategories(), id: \.self) { category in
                    NavigationLink(value: category) {
                        Label(category.displayName, systemImage: category.displayImageName)
                    }
                }
            }
            
            Section("Other Categories") {
                NavigationLink(destination: ChartsView()) {
                    Label("Charts", systemImage: "chart.line.uptrend.xyaxis")
                }
            }
        }
    }
}

#Preview {
    SidebarView(selectedCategory: .constant(PreviewData.shared.closedCategory))
}
