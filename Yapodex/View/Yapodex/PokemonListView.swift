//
//  Home.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject private var vm = PokedexViewModel()

    @State private var searchText = ""
    @State private var showFilterSheet = false
    @State private var showSortActionSheet = false
    @State private var showStatActionSheet = false
    @State private var listFilters = Filters(
        types: [], ordering: .numerical, isAscending: true, generation: [], evYield: []
    )
    @State private var showPokemonDetailView = false

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        SearchBar(searchText: $searchText)
                        SearchFilters(filters: $listFilters)
                        PokemonListGrid(pokemon: vm.pokedex?.pokedex ?? [], searchText: searchText, showPokemonDetailView: $showPokemonDetailView, listFilters: listFilters)
                            .animation(.spring())
                    }
                }.navigationTitle("Yapodex")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showSortActionSheet.toggle()
                            }, label: {
                                Image(systemName: "arrow.up.arrow.down")
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showFilterSheet.toggle()
                            }, label: {
                                Image(systemName: "ellipsis.rectangle.fill")
                            })
                        }
                    }
            }.navigationViewStyle(StackNavigationViewStyle())
            Spacer()
                .sheet(isPresented: $showFilterSheet, content: {
                    FilterSheet(listFilters: $listFilters)
                })
            Spacer()
                .actionSheet(isPresented: $showSortActionSheet, content: {
                    ActionSheet(
                        title: Text("Sort by.."),
                        buttons: [
                            .default(Text("Pokedex No."), action: {
                                listFilters.ordering = .numerical
                            }),
                            .default(Text("A-Z"), action: {
                                listFilters.ordering = .alphabetical
                            }),
                            .default(Text("Stat"), action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showStatActionSheet.toggle()
                                }
                            }),
                            .default(Text(listFilters.isAscending ? "Descending" : "Ascending"), action: {
                                listFilters.isAscending.toggle()
                            }),
                            .cancel()
                        ]
                    )
                })
            Spacer()
                .actionSheet(isPresented: $showStatActionSheet, content: {
                    ActionSheet(
                        title: Text("Sort by.."),
                        buttons: [
                            .default(Text("HP"), action: {
                                listFilters.ordering = .hpstat
                            }),
                            .default(Text("Attack"), action: {
                                listFilters.ordering = .atkstat
                            }),
                            .default(Text("Defense"), action: {
                                listFilters.ordering = .defstat
                            }),
                            .default(Text("Special Attack"), action: {
                                listFilters.ordering = .spastat
                            }),
                            .default(Text("Special Defense"), action: {
                                listFilters.ordering = .spdstat
                            }),
                            .default(Text("Speed"), action: {
                                listFilters.ordering = .spestat
                            }),
                            .cancel()
                        ]
                    )
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonListView()
        }
        PokemonListView().preferredColorScheme(.dark)
    }
}

private struct SearchFilters: View {
    @Binding var filters: Filters
    
    var body: some View {
//        LazyVGrid(columns: [
//            GridItem(.flexible()),
//            GridItem(.flexible()),
//            GridItem(.flexible())
//        ], alignment: .center, spacing: nil, content: {
//
//        }).padding(.horizontal)
        HStack {
            ForEach(filters.types, id: \.self) { filter in
                HStack {
                    Text(filter.rawValue.uppercased())
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .font(Font.caption.bold())
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(PokemonUtils.PokemonTypingColor(type: filter))
                .cornerRadius(6.0)
                .padding(.top, 8)
                .animation(.spring())
                .onTapGesture(perform: {
                    guard let index = filters.types.firstIndex(of: filter) else { return }
                    filters.types.remove(at: index)
                })
            }
        }
        HStack {
            if !filters.generation.isEmpty {
                ForEach(filters.generation, id: \.self) { generation in
                    HStack {
                        Text(generation)
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .font(Font.caption.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .cornerRadius(6.0)
                    .padding(.top, 8)
                    .animation(.spring())
                    .onTapGesture(perform: {
                        guard let index = filters.generation.firstIndex(of: generation) else { return }
                        filters.generation.remove(at: index)
                    })
                }
            }
            if !filters.evYield.isEmpty {
                ForEach(filters.evYield, id: \.self) { ev in
                    HStack {
                        Text("\(ev) EVs")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .font(Font.caption.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    .cornerRadius(6.0)
                    .padding(.top, 8)
                    .animation(.spring())
                    .onTapGesture(perform: {
                        guard let index = filters.evYield.firstIndex(of: ev) else { return }
                        filters.evYield.remove(at: index)
                    })
                }
            }
        }
    }
}


private func filterPokemon(pokemon: [Pokemon], searchText: String, filters: Filters) -> [Pokemon] {
    var filteredPokemon: [Pokemon] = []
    for mon in pokemon {
        if filterBySearch(pokemon: mon, searchText: searchText) {
            if filterByTypes(pokemon: mon, types: filters.types) {
                if filterByGen(id: mon.id, genFilters: filters.generation) {
                    filteredPokemon.append(mon)
                }
            }
        }
    }

    filteredPokemon.sort { (monA, monB) -> Bool in
        switch filters.ordering {
        case .numerical:
            return monA.id < monB.id
        case .alphabetical:
            return monA.name < monB.name
        case .hpstat:
            return monA.base.hp < monB.base.hp
        case .atkstat:
            return monA.base.atk < monB.base.atk
        case .defstat:
            return monA.base.def < monB.base.def
        case .spastat:
            return monA.base.spa < monB.base.spa
        case .spdstat:
            return monA.base.spd < monB.base.spd
        case .spestat:
            return monA.base.spe < monB.base.spe
        }
    }
    
    if !filters.isAscending {
        filteredPokemon.reverse()
    }
    
    return filteredPokemon
}

private func filterBySearch(pokemon: Pokemon, searchText: String) -> Bool {
    if pokemon.name.contains(searchText) || searchText.isEmpty {
        return true
    }
    return false
}

private func filterByTypes(pokemon: Pokemon, types: [PokemonTyping]) -> Bool {
    if types.count == 0 { return true }
    if types.count == 1 {
        if pokemon.type.count == 1 {
            if pokemon.type[0] == types[0] {
                return true
            }
        } else {
            if pokemon.type[0] == types[0] || pokemon.type[1] == types[0] {
                return true
            }
        }
    } else if types.count == 2 {
        if pokemon.type.count == 2 {
            if (pokemon.type[0] == types[0] && pokemon.type[1] == types[1]) || (pokemon.type[0] == types[1] && pokemon.type[1] == types[0]) {
                return true
            }
        }
    }
    return false
}

private func filterByGen(id: Int, genFilters: [String]) -> Bool {
//    let PokemonGeneration = PokemonGenerationFilter(rawValue: genFilter) ?? PokemonGenerationFilter.none
//    switch PokemonGeneration {
//    case .gen1:
//        if id > 0 && id <= 151 { return true }
//        return false
//    case .gen2:
//        if id > 151 && id <= 251 { return true }
//        return false
//    case .gen3:
//        if id > 251 && id <= 386 { return true }
//        return false
//    case .gen4:
//        if id > 386 && id <= 493 { return true }
//        return false
//    case .gen5:
//        if id > 493 && id <= 649 { return true }
//        return false
//    case .gen6:
//        if id > 649 && id <= 721 { return true }
//        return false
//    case .gen7:
//        if id > 721 && id <= 809 { return true }
//        return false
//    case .gen8:
//        if id > 809 && id <= 898 { return true }
//        return false
//    case .none:
//        return true
//    }
    return true
}

private struct PokemonListGrid: View {
    let pokemon: [Pokemon]
    let filteredPokemon: [Pokemon]
    let searchText: String
    @Binding var showPokemonDetailView: Bool

    init(pokemon: [Pokemon], searchText: String, showPokemonDetailView: Binding<Bool>, listFilters: Filters) {
        self.pokemon = pokemon
        self.searchText = searchText
        self._showPokemonDetailView = showPokemonDetailView
        self.filteredPokemon = filterPokemon(pokemon: pokemon, searchText: searchText, filters: listFilters)
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
            ForEach(filteredPokemon.indices, id: \.self) { index in
                NavigationLink(
                    destination: PokemonDetailView(pokemon: filteredPokemon, index: index),
                    label: {
                        PokemonListRow(pokemon: filteredPokemon[index])
                    }
                ).foregroundColor(Color(.label))
                Divider().padding(.horizontal, 8)
            }
        })
    }
}

private struct PokemonListRow: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            Image("\(pokemon.id)")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 42)
                .padding(.trailing, 4)
            Text(pokemon.name)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            Spacer()
            ForEach(pokemon.type, id: \.self) { type in
                TypeIcon(typing: type)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .contextMenu {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Label("Add To Favourites", systemImage: "star.fill")
            })
        }
    }
}
