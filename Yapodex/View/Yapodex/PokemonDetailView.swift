//
//  PokemonDetailView.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject private var vm: DetailedPokemonViewModel
    let pokemon: [Pokemon]
    @State var index: Int
    @State private var displayMode = "levelup"

    init(pokemon: [Pokemon], index: Int) {
        self.pokemon = pokemon
        self.index = index
        self.vm = DetailedPokemonViewModel(name: pokemon[index].name)
    }

    var body: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                PokemonImage(pokemon: pokemon, index: $index, vm: vm).id(0)
                InitialInfo(pokemonDetail: vm.pokemonDetail)
                BaseStats(pokemonDetail: vm.pokemonDetail)
                Abilities(pokemonAbilities: vm.pokemonDetail.abilities)
                Evolutions(index: $index, scrollView: scrollView, pokemonDetail: vm.pokemonDetail)
                Moves(displayMode: $displayMode, moveLearnSets: vm.pokemonDetail.moveLearnSets)
            }
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

private struct PokemonImage: View {
    let pokemon: [Pokemon]
    @Binding var index: Int
    var vm: DetailedPokemonViewModel

    var body: some View {
        ZStack {
            SpashView(animationType: .circle, color: PokemonUtils.PokemonTypingColor(type: pokemon[index].type[0]))
                .ignoresSafeArea()
                .clipped()
            Rectangle().foregroundColor(.white).opacity(0.42)
            TabView(selection: $index) {
                ForEach(pokemon.indices, id: \.self) { index in
                    Image("art__\(String(format: "%03d", pokemon[index].id))")
                        .resizable()
                        .scaledToFit()
                        .tag(index)
                        .padding(42)
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: index, perform: { index in
                vm.getPokemon(name: pokemon[index].name)
            })
            HStack {
                Button(action: {
                    index -= 1
                }, label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                })
                .padding()
                    .disabled(index <= 0)
                Spacer()
                Button(action: {
                    index += 1
                    
                }, label: {
                    Image(systemName: "chevron.forward")
                        .imageScale(.large)
                })
                .padding()
                    .disabled(index >= pokemon.count - 1)
            }
        }
        .frame(height: 272)
    }
}

private struct InitialInfo: View {
    var pokemonDetail: PokemonDetail

    var body: some View {
        VStack {
            NavigationLink(
                destination: PokemonTypeEffectiveness(pokemonId: pokemonDetail.nationalId, pokemonTypes: pokemonDetail.types),
                label: {
                    HStack {
                        ForEach(pokemonDetail.types, id: \.self) { type in
                            TypeIcon(typing: type)
                        }
                    }
                }
            )
            Text(pokemonDetail.name)
                .font(.system(size: 32, weight: .bold, design: .monospaced))
            Text("#\(String(format: "%03d", pokemonDetail.nationalId))")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
        }.padding(8)
    }
}

private struct BaseStats: View {
    var pokemonDetail: PokemonDetail

    var body: some View {
        VStack {
            Text("Base Stats")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            VStack(spacing: 12) {
                BaseStatBar(statName: "HP ", statValue: Double(pokemonDetail.baseStats.hp))
                BaseStatBar(statName: "ATK", statValue: Double(pokemonDetail.baseStats.atk))
                BaseStatBar(statName: "DEF", statValue: Double(pokemonDetail.baseStats.def))
                BaseStatBar(statName: "SPA", statValue: Double(pokemonDetail.baseStats.spa))
                BaseStatBar(statName: "SPD", statValue: Double(pokemonDetail.baseStats.spd))
                BaseStatBar(statName: "SPE", statValue: Double(pokemonDetail.baseStats.spe))
            }
            Text("Total: \(pokemonDetail.baseStats.hp + pokemonDetail.baseStats.atk + pokemonDetail.baseStats.def + pokemonDetail.baseStats.spa + pokemonDetail.baseStats.spd + pokemonDetail.baseStats.spe)")
        }.padding(8)
            .font(.system(size: 16, weight: .regular, design: .monospaced))
            .background(Color(.systemGray6))
    }
}

private struct BaseStatBar: View {
    let statName: String
    let statValue: Double
    
    var body: some View {
        ProgressView("\(statName)  \(String(format: "%.0f", statValue))", value: min(statValue, 150.0), total: 150.0)
            .progressViewStyle(LinearProgressViewStyle(tint: PokemonUtils.PokemonStatsColor(stat: Int(statValue))))
            .animation(.default)
    }
}

private struct Abilities: View {
    var pokemonAbilities: [PokemonAbility]
    
    var body: some View {
        VStack {
            Text("Abilities")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            ForEach(pokemonAbilities, id: \.self) { ability in
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(ability.name)
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

private struct Evolutions: View {
    @Binding var index: Int
    let scrollView: ScrollViewProxy
    let pokemonDetail: PokemonDetail
    
    var body: some View {
        VStack {
            Text("Evolutions")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            if (pokemonDetail.evolutionFrom != nil) {
                VStack(alignment: .leading) {
                    Text("Evolves From:")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    Button(action: {
                        index = (pokemonDetail.evolutionFrom?.id ?? 1) - 1
                        withAnimation {
                            scrollView.scrollTo(0)
                        }
                    }, label: {
                        PokemonEvolutionRow(id: pokemonDetail.evolutionFrom?.id ?? 1, name:  pokemonDetail.evolutionFrom?.name ?? "", types:  pokemonDetail.evolutionFrom?.types ?? [])
                    }).foregroundColor(Color(.label))
                }
            }
            if (pokemonDetail.evolutionFrom != nil && !pokemonDetail.evolutions.isEmpty) {
                Divider()
            }
            if (!pokemonDetail.evolutions.isEmpty) {
                VStack(alignment: .leading) {
                    Text("Evolves To:")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
                        ForEach(pokemonDetail.evolutions, id: \.self) { evolution in
                            Button(action: {
                                index = evolution.id - 1
                                withAnimation {
                                    scrollView.scrollTo(0)
                                }
                            }, label: {
                                PokemonEvolutionRow(id: evolution.id, name: evolution.name, types: evolution.types)
                            }).foregroundColor(Color(.label))
                        }
                    })
                }
            }
        }.padding(8)
            .background(Color(.systemGray6))
    }
}

private struct PokemonEvolutionRow: View {
    let id: Int
    let name: String
    let types: [PokemonTyping]
    
    var body: some View {
        HStack {
            Image("\(id)")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(name)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            Spacer()
            ForEach(types, id: \.self) { type in
                TypeIcon(typing: type)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

private struct Moves: View {
    @Binding var displayMode: String
    let moveLearnSets: [PokemonLearnsets]

    var body: some View {
        VStack {
            Text("Moves")
                .font(.system(size: 22, weight: .bold, design: .monospaced))
                .padding(.bottom, 4)
            Picker("type", selection: $displayMode) {
                Text("Level Up").tag("levelup")
                Text("TM/HM").tag("tmhm")
                Text("Egg Moves").tag("eggmoves")
                Text("Tutor").tag("tutor")
            }.pickerStyle(SegmentedPickerStyle())
            LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
                ForEach(moveLearnSets[0].learnset, id: \.self) { move in
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            PokemonMoveRow(move: move)
                        }
                    ).foregroundColor(Color(.label))
                    Divider()
                }
            })
        }.padding(8)
    }
}

private struct PokemonMoveRow: View {
    let move: PokemonMoveset
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(move.move)
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                if (move.level != nil) {
                    Text("\(move.level!)")
                        .font(.system(size: 12, weight: .light, design: .monospaced))
                }
                if (move.tm != nil) {
                    Text(move.tm!)
                        .font(.system(size: 12, weight: .light, design: .monospaced))
                }
            }
            Spacer()
            Text("50")
                .padding(.horizontal)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
//            TypeIcon(typing: PokemonTyping.grass)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
