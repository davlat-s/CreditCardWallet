//
//  CreditCardDetail.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 8/25/24.
//

import SwiftUI

struct CreditCardDetail: View {
    
    let card: CreditCard?
    
    var body: some View {
        if let card = card {
            Text(card.name)
            
        } else {
            Text("Select Card")
        }
    }
}

// MARK: Previews

#Preview("card: sample") {
    CreditCardDetail(card: SampleData.shared.creditCard)
        .modelContainer(SampleData.shared.modelContainer)
}

#Preview("card: nil") {
    CreditCardDetail(card: nil)
        .modelContainer(SampleData.shared.modelContainer)
}
