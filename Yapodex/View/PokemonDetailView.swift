//
//  PokemonDetailView.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: [Pokemon]
    @State var index: Int

    var body: some View {
        ScrollView {
            PokemonImage(pokemon: pokemon, index: $index)
            InitialInfo(pokemon: pokemon[index])
            BaseStats(pokemon: pokemon[index])
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
        PokemonListView()
    }
}

struct PokemonImage: View {
    let pokemon: [Pokemon]
    @Binding var index: Int

    var body: some View {
        ZStack {
            TabView(selection: $index) {
                ForEach(pokemon.indices, id: \.self) { index in
                    Image("art__\(String(format: "%03d", pokemon[index].id))")
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                        .padding()
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack {
                Button(action: {
                    index -= 1
                }, label: {
                    Image(systemName: "chevron.backward")
                })
                    .disabled(index <= 0)
                Spacer()
                Button(action: {
                    index += 1
                }, label: {
                    Image(systemName: "chevron.forward")
                })
                    .disabled(index >= pokemon.count - 1)
            }.padding()
        }.background(Color(.systemGray6))
        .frame(height: 200)
    }
}

struct InitialInfo: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            NavigationLink(
                destination: PokemonTypeEffectiveness(pokemon: pokemon),
                label: {
                    HStack {
                        ForEach(pokemon.type, id: \.self) { type in
                            TypeIcon(typing: type)
                        }
                    }
                }
            )
            Text(pokemon.name)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
            Text("#\(String(format: "%03d", pokemon.id))")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
        }.padding(8)
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
        }.padding(8)
            .font(.system(size: 16, weight: .regular, design: .monospaced))
            .background(Color(.systemGray6))
    }
}

struct BaseStatBar: View {
    let statName: String
    let statValue: Double
    var body: some View {
        ProgressView("\(statName)  \(String(format: "%.0f", statValue))", value: statValue, total: 150)
            .progressViewStyle(LinearProgressViewStyle(tint: PokemonUtils.PokemonStatsColor(stat: Int(statValue))))
            .animation(.default)
    }
}
