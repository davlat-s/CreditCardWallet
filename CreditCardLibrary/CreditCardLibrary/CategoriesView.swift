import SwiftUI

struct CategoriesView: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Categories") {
                    NavigationLink("All") {
                        CategoryAllView()
                    }
                    NavigationLink("Business") {
                        CategoryBusinessView()
                    }
                    NavigationLink("Personal") {
                        CategoryPersonalView()
                    }
                    NavigationLink("Closed") {
                        CategoryClosedView()
                    }
                    
                }
                Section("Tools") {
                    NavigationLink("Dashboard") {
                        DashboardView()
                    }
                }
            }
        }
    }
}

#Preview {
    CategoriesView()
        .environment(ModelData())
}
