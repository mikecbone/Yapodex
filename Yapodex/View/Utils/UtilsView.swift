//
//  UtilsView.swift
//  Yapodex
//
//  Created by Mike Bone on 25/04/2021.
//

import SwiftUI

struct UtilsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
            }.navigationTitle("Utilities")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UtilsView_Previews: PreviewProvider {
    static var previews: some View {
        UtilsView()
    }
}
