import SwiftUI

struct ContentView: View {
    @State private var isShowingAddCardSheet = false
    
    var body: some View {
        NavigationSplitView{
            CategoriesView()
        }content: {
            Text("Select a category")
        }detail: {
            Text("Select a card")
        }
        .navigationTitle("Card Library")
        .toolbar(content: {
            Button("Add Card", systemImage: "plus.circle") {isShowingAddCardSheet = true}
        })
    }
}


#Preview {
    ContentView()
}
