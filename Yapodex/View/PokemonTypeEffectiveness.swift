//
//  PokemonTypeEffectiveness.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import SwiftUI

struct PokemonTypeEffectiveness: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            HStack {
                Image("\(pokemon.id)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                ForEach(pokemon.type, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            Divider()
        }.navigationTitle("Type Effectiveness")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PokemonTypeEffectiveness_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PokemonTypeEffectiveness(
                pokemon: .init(
                    id: 1, name: "Bulbasaur", type: [PokemonTyping.grass, PokemonTyping.poison], base: PokemonBaseStats(
                        HP: 50, ATK: 50, DEF: 50, SPA: 50, SPD: 50, SPE: 50
                    )
                )
            )
        }
    }
}
