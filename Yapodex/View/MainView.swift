//
//  MainView.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PokemonListView()
                .tabItem {
                    Label("Yapodex", systemImage: selectedTab == 0 ? "heart.text.square.fill" : "heart.text.square")
                }
                .tag(0)
            MovesList()
                .tabItem {
                    Label("Moves", systemImage: selectedTab == 1 ? "bolt.horizontal.circle.fill" : "bolt.horizontal.circle")
                }
                .tag(1)
            AbilitiesList()
                .tabItem {
                    Label("Abilities", systemImage: selectedTab == 2 ? "leaf.fill" : "leaf")
                }
                .tag(2)
            UtilsView()
                .tabItem {
                    Label("Utils", systemImage: selectedTab == 3 ? "wrench.and.screwdriver.fill" : "wrench.and.screwdriver")
                }
                .tag(3)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: selectedTab == 4 ? "gearshape.fill" : "gearshape")
                }
                .tag(4)
        }.accentColor(Color(#colorLiteral(red: 0.8974402547, green: 0.4077255726, blue: 0.2946455479, alpha: 1)))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().preferredColorScheme(.dark)
    }
}
