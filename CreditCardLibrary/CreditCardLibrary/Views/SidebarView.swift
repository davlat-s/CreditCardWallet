import SwiftUI

struct SidebarView: View {
    @Binding var selectedCategory: SideBarCategories
    @AppStorage("isExpanded") private var isExpanded: Bool = false
    @Binding var banksWCards: [Bank]
    // TODO: make isExpanded persistent across user sessions.

    private func sortedCategories() -> [SideBarCategories] {
        let categories: [SideBarCategories] = [
            .business,
            .personal,
            .all
        ]
        return categories.sorted { $0.displayName < $1.displayName }
    }
    
    var body: some View {
        List(selection: $selectedCategory) {
            Section("Open Cards") {
                ForEach(sortedCategories(), id: \.self) { category in
                    NavigationLink(value: category) {
                        Label(category.displayName, systemImage: category.displayImageName)
                    }
                }
            }
            
            Section("Other Categories") {
                ForEach([SideBarCategories.closed], id: \.self) { category in
                    NavigationLink(value: category) {
                        Label(category.displayName, systemImage: category.displayImageName)
                    }
                }
            }
        }
    }
}

#Preview {
    SidebarView(selectedCategory: .constant(PreviewData.shared.closedCategory), banksWCards: .constant(Bank.sampleData))
}
