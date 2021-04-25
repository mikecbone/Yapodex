//
//  MovesLists.swift
//  Yapodex
//
//  Created by Mike Bone on 25/04/2021.
//

import SwiftUI

struct MovesList: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
            }.navigationTitle("Moves")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MovesLists_Previews: PreviewProvider {
    static var previews: some View {
        MovesList()
    }
}
