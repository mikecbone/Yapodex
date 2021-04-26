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
    @State private var listFilters = Filters(types: [], ordering: .numerical, isAscending: true, generation: "", evYield: "")
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
                        title: Text("Sort by."),
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
            if !filters.generation.isEmpty {
                HStack {
                    Text(filters.generation)
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
                    filters.generation = ""
                })
            }
            if !filters.evYield.isEmpty {
                HStack {
                    Text(filters.evYield)
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
                    filters.evYield = ""
                })
            }
        }
    }
}


private func filterPokemon(pokemon: [Pokemon], searchText: String, filters: Filters) -> [Pokemon] {
//    var filteredPokemon = pokemon.filter {"\($0)".contains(searchText) || searchText.isEmpty}
//    filteredPokemon = filteredPokemon.filter {filters.types.contains($0.type[0]) || filters.types.isEmpty}
//    return filteredPokemon
    var filteredPokemon: [Pokemon] = []
    for mon in pokemon {
        if mon.name.contains(searchText) || searchText.isEmpty {
            if filters.types.count == 1 {
                if mon.type.count == 1 {
                    if mon.type[0] == filters.types[0] {
                        filteredPokemon.append(mon)
                    }
                } else {
                    if mon.type[0] == filters.types[0] || mon.type[1] == filters.types[0] {
                        filteredPokemon.append(mon)
                    }
                }
            } else if filters.types.count == 2 {
                if mon.type.count == 2 {
                    if (mon.type[0] == filters.types[0] && mon.type[1] == filters.types[1]) || (mon.type[0] == filters.types[1] && mon.type[1] == filters.types[0]) {
                        filteredPokemon.append(mon)
                    }
                }
            } else {
                filteredPokemon.append(mon)
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
            return monA.base.HP < monB.base.HP
        case .atkstat:
            return monA.base.ATK < monB.base.ATK
        case .defstat:
            return monA.base.DEF < monB.base.DEF
        case .spastat:
            return monA.base.SPA < monB.base.SPA
        case .spdstat:
            return monA.base.SPD < monB.base.SPD
        case .spestat:
            return monA.base.SPE < monB.base.SPE
        }
    }
    
    if !filters.isAscending {
        filteredPokemon.reverse()
    }
    
    return filteredPokemon
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
    }
}

private struct SearchBar: View {
    @Binding var searchText: String
    @State private var isSearching = false

    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 22)
                    .padding(.trailing, 22)
            }
            .padding(12)
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.leading, 16)
            .padding(.trailing, isSearching ? CGFloat(4) : CGFloat(16))
            .onTapGesture {
                self.isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if searchText != "" {
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                        })
                    }
                }.padding(.horizontal, 22)
                    .foregroundColor(Color(#colorLiteral(red: 0.7494884133, green: 0.7494884133, blue: 0.7566651702, alpha: 1)))
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())

            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing, 16)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
            }
        }
    }
}
