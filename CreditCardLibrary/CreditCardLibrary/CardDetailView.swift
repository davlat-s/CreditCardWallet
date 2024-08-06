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
                HStack{
                    Text("Annual Fee")
                        .padding(.horizontal)
                    Spacer()
                    Text("$\(String(creditcard.annualFee))")
                        .padding(.horizontal)

                }
                HStack{
                    Text("Credit Limit")
                        .padding(.horizontal)
                    Spacer()
                    Text("$\(String(Int(creditcard.creditLimit)))")
                        .padding(.horizontal)
                }
                HStack{
                    Text("Open Date")
                        .padding(.horizontal)
                    Spacer()
                    Text(creditcard.openDate)
                        .padding(.horizontal)
                }
                HStack{
                    Text("Bank Name")
                        .padding(.horizontal)
                    Spacer()
                    Text(creditcard.bankName)
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CardDetailView(creditcard: ModelData().creditCardList[2])
        .environment(ModelData())
}
