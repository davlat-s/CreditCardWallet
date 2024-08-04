//
//  MainView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/3/24.
//

import SwiftUI

struct MainView: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        NavigationSplitView{
            CategoriesView(categoriesList: categoriesList)
        }content: {
            Text("Placeholder")
        }detail: {
            Text("Placeholder")
        }
    }
}

#Preview {
    MainView()
        .environment(ModelData())
}
