//
//  CardRowView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/4/24.
//

import SwiftUI

struct CardRowView: View {
    @Environment(ModelData.self) private var modelData
    var creditcard: CreditCard
    
    var body: some View {
        HStack {
            creditcard.image
                .resizable()
                .frame(width: 65, height: 40)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 3, height: 5)))
                
            Text(creditcard.cardName)
                .padding()
            Spacer()
            
            Text("$\(String(creditcard.annualFee))")
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    CardRowView(creditcard: ModelData().creditCardList[1])
        .environment(ModelData())
}
