//
//  SelectCardView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 2/4/25.
//

import SwiftUI

struct SelectCardView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Select a card")
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
                .fixedSize() // Ensures text takes only as much space as it needs

            Spacer()
        }
    }
}

#Preview {
    SelectCardView()
}
