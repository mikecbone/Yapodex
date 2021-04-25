//
//  AbilitiesList.swift
//  Yapodex
//
//  Created by Mike Bone on 25/04/2021.
//

import SwiftUI

struct AbilitiesList: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
            }.navigationTitle("Abilities")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())    }
}

struct AbilitiesList_Previews: PreviewProvider {
    static var previews: some View {
        AbilitiesList()
    }
}
