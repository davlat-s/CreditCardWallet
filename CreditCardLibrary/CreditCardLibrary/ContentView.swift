import SwiftUI


struct ContentView: View {
    
    var body: some View {
        NavigationSplitView{
            CategoriesView()
        }content: {
            Text("Select a category")
        }detail: {
            Text("Select a card")
        }
        .navigationTitle("Card Library")
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
