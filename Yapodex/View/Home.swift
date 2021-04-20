//
//  Home.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import SwiftUI

struct Home: View {
    let pokemon: [Pokemon] = [
        .init(id: 1, name: "Bulbasaur", primaryType: PokemonTyping.grass, secondaryType: PokemonTyping.poison),
        .init(id: 2, name: "Ivysaur", primaryType: PokemonTyping.grass, secondaryType: PokemonTyping.poison),
        .init(id: 3, name: "Venusaur", primaryType: PokemonTyping.grass, secondaryType: PokemonTyping.poison),
        .init(id: 4, name: "Charmander", primaryType: PokemonTyping.fire, secondaryType: nil),
        .init(id: 5, name: "Charmeleon", primaryType: PokemonTyping.fire, secondaryType: nil),
        .init(id: 6, name: "Charizard", primaryType: PokemonTyping.fire, secondaryType: PokemonTyping.flying),
        .init(id: 7, name: "Squirtle", primaryType: PokemonTyping.water, secondaryType: nil),
        .init(id: 8, name: "Wartortle", primaryType: PokemonTyping.water, secondaryType: nil),
        .init(id: 9, name: "Blastoise", primaryType: PokemonTyping.water, secondaryType: nil),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                        Spacer()
                    }
                    .foregroundColor(Color(.gray))
                    .padding(8)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: nil, content: {
                        ForEach(pokemon, id: \.self) { pokemon in
                            HStack {
                                Image(systemName: "tortoise.fill")
                                    .padding(.trailing, 4)
                                Text(pokemon.name)
                                Spacer()
                                TypeIcon(typing: pokemon.primaryType)
                                if ((pokemon.secondaryType) != nil) {
                                    TypeIcon(typing: pokemon.secondaryType!)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        }
                    })
                }
            }.navigationTitle("Yapodex")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "arrow.up.arrow.down")
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TypeIcon: View {
    let typing: PokemonTyping
    
    var body: some View {
        Text(typing.rawValue)
            .font(.system(size: 16, weight: .bold))
            .frame(width: 66)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(PokemonUtils.PokemonTypingColor(type: typing))
            .foregroundColor(.white)
            .cornerRadius(6.0)
    }
}
