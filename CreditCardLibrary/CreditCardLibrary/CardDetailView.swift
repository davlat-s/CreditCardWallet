//
//  CardDetailView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/5/24.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(ModelData.self) private var modelData

    var creditcard: CreditCard
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CardImageView(image: creditcard.image)
                RowDetailViewHelper(rowName: "Annual Fee", rowValue: String("$\(creditcard.annualFee)"))
                RowDetailViewHelper(rowName: "Credit Limit", rowValue: String("$\(Int(creditcard.creditLimit))"))
                RowDetailViewHelper(rowName: "Open Date", rowValue: creditcard.formattedDate(  date: creditcard.openDate))
            }
        }
    }
}

#Preview {
    CardDetailView(creditcard: ModelData().creditCardListSortedNewest[2])
        .environment(ModelData())
}
