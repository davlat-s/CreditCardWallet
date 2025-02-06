//
//  CardRowView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 2/4/25.
//

import SwiftUI

struct CardRowView: View {
    @State var creditCard: CreditCard
    var body: some View {
        HStack {
            CardView(creditCard: creditCard)
                .frame(width: CreditCard.cardWidth / 15, height: CreditCard.cardHeight / 50)
                .scaleEffect(0.15)
                .padding(30)
            Text(creditCard.name)
            Spacer()
        }

    }
}

#Preview {
    CardRowView(creditCard: (PreviewData.shared.creditCard))
}
