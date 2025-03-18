//
//  SettingsView.swift
//  CreditCardLibrary
//
//  Created by Davlat Sirojitdinov on 3/14/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            
            BankSettingsView()
                .tabItem {
                    Label("Banks", systemImage: "building.columns")
                }
            PromotionsSettingsView()                .tabItem {
                    Label("APR promotions", systemImage: "percent")
                }
            BonusSettingsView()
                .tabItem {
                    Label("Bonuses", systemImage: "dollarsign.arrow.circlepath")
                }
            SettingsTabView()
                .tabItem{
                    Label("Settings", systemImage:"gear")
                }
        }
        .frame(width: 400, height: 400)
        .padding()
//        .modifier(ColorShemeModifier())
    }
    
}

#Preview {
    SettingsView()
}
