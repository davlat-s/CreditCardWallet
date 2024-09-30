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
                                    content: {
                                        ForEach(banksWCards, id: \.self) { bank in
                                            NavigationLink(value: SideBarCategories.bank(bank)) {
                                                Text(bank.name)
                                            }
                                            .simultaneousGesture(TapGesture().onEnded {
                                                selectedCategory = .bank(bank)  // Update the selected category to the bank
                                            })
                                        }
                                    },
                                    label: {
                                        Label("By Bank", systemImage: "building.columns")
                                            .onTapGesture {
                                                withAnimation() {
                                                    isExpanded.toggle()
                                                }
                                            }
                                    }
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
    SidebarView(selectedCategory: .constant(PreviewData.shared.closedCategory), banksWCards: .constant(Bank.sampleData))
}
