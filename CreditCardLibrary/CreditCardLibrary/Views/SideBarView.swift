import SwiftUI

struct SideBarView: View {
    @Binding var selectedCategory: SideBarCategories
    @State private var isOpenExpanded: Bool = true

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
    SideBarView(selectedCategory: .constant(SampleData.shared.closedCategory))
}
