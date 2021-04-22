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
            InitialInfo(pokemon: pokemon)
            BaseStats(pokemon: pokemon)
        }.navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: Favourite action
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
            PokemonDetailView(pokemon: .init(id: 1, name: "Bulbasaur", type: [PokemonTyping.grass, PokemonTyping.poison], base: PokemonBaseStats(HP: 45, ATK: 49, DEF: 49, SPA: 65, SPD: 65, SPE: 45)))
        }
        PokemonListView()
    }
}

struct PokemonImage: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            Button(action: {
                // TODO: Load previous pokemon
            }, label: {
                Image(systemName: "chevron.backward")
            })
            Spacer()
            Image("art__\(String(format: "%03d", pokemon.id))")
                .resizable()
                .scaledToFit()
            Spacer()
            Button(action: {
                // TODO: Load next pokemon
            }, label: {
                Image(systemName: "chevron.forward")
            })
        }
        .padding()
        .background(Color(.systemGray6))
        .frame(height: 200)
    }
}

struct InitialInfo: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            HStack {
                ForEach(pokemon.type, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            Text(pokemon.name)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
            Text("#\(String(format: "%03d", pokemon.id)) - Seed Pokemon")
        }.padding()
    }
}

struct BaseStats: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            Text("Base Stats")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
            VStack(spacing: 12) {
                BaseStatBar(statName: "HP ", statValue: Double(pokemon.base.HP))
                BaseStatBar(statName: "ATK", statValue: Double(pokemon.base.ATK))
                BaseStatBar(statName: "DEF", statValue: Double(pokemon.base.DEF))
                BaseStatBar(statName: "SPA", statValue: Double(pokemon.base.SPA))
                BaseStatBar(statName: "SPD", statValue: Double(pokemon.base.SPD))
                BaseStatBar(statName: "SPE", statValue: Double(pokemon.base.SPE))
            }.padding(.top, 4)
            Text("Total: \(pokemon.base.HP + pokemon.base.ATK + pokemon.base.DEF + pokemon.base.SPA + pokemon.base.SPD + pokemon.base.SPE)")
        }.padding()
            .font(.system(size: 16, weight: .regular, design: .monospaced))
            .background(Color(.systemGray6))
    }
}

struct BaseStatBar: View {
    let statName: String
    let statValue: Double
    var body: some View {
        ProgressView("\(statName)  \(String(format: "%.0f", statValue))", value: statValue, total: 255)
            .progressViewStyle(LinearProgressViewStyle(tint: PokemonUtils.PokemonStatsColor(stat: Int(statValue))))
    }
}
