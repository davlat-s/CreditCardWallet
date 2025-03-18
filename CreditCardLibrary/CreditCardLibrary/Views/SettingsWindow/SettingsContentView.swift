import SwiftUI

struct SettingsContentView: View {
    var body: some View {
        TabView {
            
            BankTabView()
                .tabItem {
                    Label("Banks", systemImage: "building.columns")
                }
            PromotionsTabView()                .tabItem {
                Label("APR promotions", systemImage: "percent")
            }
            BonusTabView()
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
    }
}

