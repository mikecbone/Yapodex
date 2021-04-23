//
//  TypeEffectivenessList.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import SwiftUI

struct TypeEffectivenessList: View {
    // TODO: This should be passed in or whatever
    @ObservedObject private var vm = PokedexViewModel()
    @State private var displayMode = "super"
    
    var body: some View {
        VStack {
            Picker("type", selection: $displayMode)  {
                Text("Super").tag("super")
                Text("Resistant").tag("resistant")
                Text("Immune").tag("immune")
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 8)
            .padding(.horizontal)
            ScrollView {
                HStack {
                    VStack {
                        TypeIcon(typing: PokemonTyping.fire)
                        TypeIcon(typing: PokemonTyping.psychic)
                        TypeIcon(typing: PokemonTyping.ice)
                        TypeIcon(typing: PokemonTyping.flying)
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.right")
                        Text("x2")
                    }
                    Spacer()
                    TypeIcon(typing: PokemonTyping.normal)
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.right")
                        Text("x2")
                    }
                    Spacer()
                    TypeIcon(typing: PokemonTyping.fire)
                }.padding()
            }
        }.navigationTitle("Type Effectiveness")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct TypeEffectivenessList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TypeEffectivenessList()
        }
    }
}
