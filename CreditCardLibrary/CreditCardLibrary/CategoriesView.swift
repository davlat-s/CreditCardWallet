//
//  CategoriesView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/3/24.
//

import SwiftUI

struct CategoriesView: View {
    let categoriesList: [String]
    
    var body: some View {
        List(categoriesList, id: \.self){category in
        Text(category)}
    }
}

#Preview {
    CategoriesView(categoriesList: categoriesList)
        .environment(ModelData())
}
