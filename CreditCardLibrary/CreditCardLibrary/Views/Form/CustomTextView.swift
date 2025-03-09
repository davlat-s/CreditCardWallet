//
//  CustomTextView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 3/8/25.
//

import SwiftUI

struct CustomTextView: View {
    
    var text: String
    var color: Color = .white
    
    var body: some View {
        Text(text)
            .font(.callout)
            .foregroundColor(color)
        
    }
}


