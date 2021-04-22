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
            PokemonImage(pokemon: pokemon)
            HStack {
                TypeIcon(typing: pokemon.primaryType)
                if pokemon.secondaryType != nil {
                    TypeIcon(typing: pokemon.secondaryType!)
                }
            }
            Text(pokemon.name)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
            Text("#00\(pokemon.id) - Seed Pokemon")
        }.navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
//                        TODO: Favourite action
                    }, label: {
                        Image(systemName: "star")
                    })
                }
            }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemon: .init(id: 1, name: "Bulbasaur", primaryType: PokemonTyping.grass, secondaryType: PokemonTyping.poison))
        }
        PokemonListView()
    }
}

struct PokemonImage: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .padding(.horizontal)
            Spacer()
            Image("art__\(String(format: "%03d", pokemon.id))")
                .resizable()
                .scaledToFit()
                .padding()
            Spacer()
            Image(systemName: "chevron.forward")
                .padding(.horizontal)
        }
        .background(Color(.systemGray6))
        .frame(height: 200)
    }
}
