import SwiftUI

struct CategoriesView: View {
    
    var body: some View {
        List {
            Section("Categories") {
                NavigationLink("Open") {
                    CategoryOpenCardsView()
                }
//                .badge()
                
                NavigationLink("Business") {
                    CategoryBusinessCardsView()
                }
//               .badge()
                
                NavigationLink("Personal") {
                    CategoryPersonalCardsView()
                }
//             .badge()
                NavigationLink("Closed") {
                    CategoryClosedCardsView()
                }
//             .badge()
                DisclosureGroup("By Bank"){
                    Text("Amex")
                    Text("Chase")
                }
            }
        }
    }
}


#Preview {
    CategoriesView()
}
