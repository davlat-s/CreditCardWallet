//
//  CategoryPersonalView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/4/24.
//

import SwiftUI

struct CategoryPersonalView: View {
    @Environment(ModelData.self) private var modelData
    
    var body: some View {
        List(filteredcards) {creditcard in
            CardRowView(creditcard: creditcard)
        }
    }
    var filteredcards: [CreditCard] { modelData.creditCardList.filter { card in !card.isBusiness}
    }
}

#Preview {
    CategoryPersonalView()
        .environment(ModelData())
}
