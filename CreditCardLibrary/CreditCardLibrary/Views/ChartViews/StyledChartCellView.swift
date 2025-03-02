//
//  StyledChartCellView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 3/2/25.
//

import SwiftUI

struct StyledChartCellView<Content: View>: View {
    let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
                .frame(width: 400, height: 300, alignment: .center)
                .padding()
                .cornerRadius(12)
                .shadow(radius: 5)
        }
}

#Preview {
    StyledChartCellView{Text("Hello")}
}
