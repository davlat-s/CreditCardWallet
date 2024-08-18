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
        .background(.ultraThickMaterial)
        .toolbar {
            ToolbarItemGroup{
                Button{isShowingAddCardSheet = true} label: {
                    Label("Add Card", systemImage: "plus")
                }
                Button{
                    
                } label: {
                    Label("Edit Card", systemImage: "pencil")
                }
            }
        }
        .sheet(isPresented: $isShowingAddCardSheet, content: {
            addCreditCardSheet()
        })
    }
}


#Preview {
    ContentView()
}
