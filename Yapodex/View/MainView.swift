//
//  MainView.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            PokemonListView()
                .tabItem {
                    Label("Yapodex", systemImage: "list.dash")
                }
            TypeEffectivenessList()
                .tabItem {
                    Label("Type", systemImage: "list.dash")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
