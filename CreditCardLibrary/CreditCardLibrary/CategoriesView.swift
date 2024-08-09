import SwiftUI

struct CategoriesView: View {
    
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        List {
            Section("Categories") {
                NavigationLink("Open") {
                    CategoryOpenCardsView()
                }
                .badge(modelData.openCardCound)

                NavigationLink("Business") {
                    CategoryBusinessCardsView()
                }
                .badge(modelData.businessCardCount)

                NavigationLink("Personal") {
                    CategoryPersonalCardsView()
                }
                .badge(modelData.personalCardCount)

                NavigationLink("Closed") {
                    CategoryClosedCardsView()
                }
                .badge(modelData.closedCardCount)
                DisclosureGroup("By Bank"){
                    Text("Amex")
                    Text("Chase")
                }
                
            }
            Section("Tools") {
                NavigationLink("Dashboard") {
                    DashboardView()
                }
                NavigationLink("Advanced") {
                    CreditCardsTableView()
                }
            }
        }
    }
}


#Preview {
    CategoriesView()
        .environment(ModelData())
}
