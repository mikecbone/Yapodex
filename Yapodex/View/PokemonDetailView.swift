//
//  PokemonDetailView.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "chevron.backward")
                    .padding(.horizontal)
                Spacer()
                Image("\(pokemon.name.lowercased())")
                    .resizable()
                    .scaledToFit()
//                    .padding(.bottom)
                Spacer()
                Image(systemName: "chevron.forward")
                    .padding(.horizontal)
            }
            .background(Color(.systemGray6))
            .frame(height: 200)
            HStack {
                TypeIcon(typing: pokemon.primaryType)
                if pokemon.secondaryType != nil {
                    TypeIcon(typing: pokemon.secondaryType!)
                }
            }
            Text(pokemon.name)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
            Text("#00\(pokemon.id) - Seed Pokemon")
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: .init(id: 1, name: "Bulbasaur", primaryType: PokemonTyping.grass, secondaryType: PokemonTyping.poison))
        PokemonListView()
    }
}
