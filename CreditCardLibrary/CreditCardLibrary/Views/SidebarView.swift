import SwiftUI

struct SidebarView: View {
    @Binding var selectedCategory: SideBarCategories
    @State private var isExpanded: Bool = true
    // TODO: make isExpanded persistent across user sessions. UserDefaultsBacked

    private func sortedCategories() -> [SideBarCategories] {
        let categories: [SideBarCategories] = [
            .business,
            .personal,
            .open
        ]
        return categories.sorted { $0.displayName < $1.displayName }
    }
    
    var body: some View {
        List(selection: $selectedCategory) {
            Section("Open") {
                ForEach(sortedCategories(), id: \.self) { category in
                    NavigationLink(value: category) {
                        Label(category.displayName, systemImage: category.displayImageName)
                    }
                }
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {Text("placeholder")},
                    label: { Label(SideBarCategories.bank.displayName, systemImage: SideBarCategories.bank.displayImageName) }
                )
            }
            
            Section("Other") {
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
    SidebarView(selectedCategory: .constant(PreviewData.shared.closedCategory))
}
