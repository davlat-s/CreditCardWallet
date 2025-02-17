//
//  DetailRowView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 2/16/25.
//

import SwiftUI

struct DetailRowView: View {
    
    var label: String
    var value: String
    
    var body: some View {
        HStack{
            Text(label)
            Spacer()
            Text(value)
        }
        .padding()
        .frame(minWidth: 200, idealWidth: 400, alignment: .center)

    }
}

#Preview {
    DetailRowView(label: "label", value: "value")
}
