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
    @State private var displayMode = "levelup"

    var body: some View {
        ScrollView {
            PokemonImage(pokemon: pokemon, index: $index)
            InitialInfo(pokemon: pokemon[index])
            BaseStats(pokemon: pokemon[index])
            Abilities()
            Evolutions()
            Moves(displayMode: $displayMode)
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
//        NavigationView {
//            PokemonDetailView(pokemon: [Pokemon(id: 1, name: "Bulbasaur", type: [PokemonTyping.grass], base: PokemonBaseStats(HP: 10, ATK: 10, DEF: 10, SPA: 10, SPD: 10, SPE: 1))], index: 1)
//        }
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
                .padding(.bottom, 4)
            VStack(spacing: 12) {
                BaseStatBar(statName: "HP ", statValue: Double(pokemon.base.HP))
                BaseStatBar(statName: "ATK", statValue: Double(pokemon.base.ATK))
                BaseStatBar(statName: "DEF", statValue: Double(pokemon.base.DEF))
                BaseStatBar(statName: "SPA", statValue: Double(pokemon.base.SPA))
                BaseStatBar(statName: "SPD", statValue: Double(pokemon.base.SPD))
                BaseStatBar(statName: "SPE", statValue: Double(pokemon.base.SPE))
            }
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
        ProgressView("\(statName)  \(String(format: "%.0f", statValue))", value: statValue, total: 150.0)
            .progressViewStyle(LinearProgressViewStyle(tint: PokemonUtils.PokemonStatsColor(stat: Int(statValue))))
            .animation(.default)
    }
}

struct Abilities: View {
    var body: some View {
        VStack {
            Text("Abilities")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            ForEach(0..<2, id: \.self) { _ in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Overgrow")
                                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                                Text("Strengthens Grass moves to inflict 1.5x damage at 1/3 max HP or less")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Image(systemName: "chevron.right")
                        }.padding(.bottom)
                    }
                ).foregroundColor(Color(.label))
            }
        }.padding(8)
    }
}

struct Evolutions: View {
    var body: some View {
        VStack {
            Text("Evolutions")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            VStack(alignment: .leading) {
                Text("Evolves From:")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
                    ForEach(0..<1, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                PokemonEvolutionRow()
                            }
                        ).foregroundColor(Color(.label))
                    }
                })
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Evolves To:")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
                    ForEach(0..<1, id: \.self) { index in
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                PokemonEvolutionRow()
                            }
                        ).foregroundColor(Color(.label))
                    }
                })
            }
        }.padding(8)
        .background(Color(.systemGray6))
    }
}

struct PokemonEvolutionRow: View {
    var body: some View {
        HStack {
            Image("1")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text("Ivysaur")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            Spacer()
            TypeIcon(typing: PokemonTyping.grass)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct Moves: View {
    @Binding var displayMode: String
    
    var body: some View {
        VStack {
            Text("Moves")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            Picker("type", selection: $displayMode)  {
                Text("Level Up").tag("levelup")
                Text("TM/HM").tag("tmhm")
                Text("Egg Moves").tag("eggmoves")
                Text("Tutor").tag("tutor")
            }.pickerStyle(SegmentedPickerStyle())
            LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
                ForEach(0..<4, id: \.self) { index in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            PokemonMoveRow()
                        }
                    ).foregroundColor(Color(.label))
                    Divider()
                }
            })
        }.padding(8)
    }
}

struct PokemonMoveRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Leech Seed")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                Text("Level 1")
                    .font(.system(size: 12, weight: .light, design: .monospaced))
            }
            Spacer()
            Text("50")
                .padding(.horizontal)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            TypeIcon(typing: PokemonTyping.grass)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
