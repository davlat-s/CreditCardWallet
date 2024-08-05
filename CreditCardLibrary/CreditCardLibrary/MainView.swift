//
//  MainView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/3/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationSplitView{
            CategoriesView()
        }detail: {
            DashboardView()
        }
        .navigationTitle("")
    }
}

#Preview {
    MainView()
        .environment(ModelData())
}
