//
//  Home.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import SwiftUI

struct PokemonListView: View {
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
        .init(id: 10, name: "Caterpie", primaryType: PokemonTyping.bug, secondaryType: nil),
        .init(id: 11, name: "Metapod", primaryType: PokemonTyping.bug, secondaryType: nil),
        .init(id: 12, name: "Butterfree", primaryType: PokemonTyping.bug, secondaryType: PokemonTyping.flying),
        .init(id: 13, name: "Weedle", primaryType: PokemonTyping.bug, secondaryType: PokemonTyping.poison),
        .init(id: 14, name: "Kakuna", primaryType: PokemonTyping.bug, secondaryType: PokemonTyping.poison),
        .init(id: 15, name: "Beedrill", primaryType: PokemonTyping.bug, secondaryType: PokemonTyping.poison),
    ]

    @State private var searchText = ""
    @State private var showFilterSheet = false
    @State private var showPokemonDetailView = false

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        SearchBar(searchText: $searchText)
                        PokemonListGrid(pokemon: pokemon, searchText: searchText, showPokemonDetailView: $showPokemonDetailView)
                    }
                }.navigationTitle("Yapodex")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showFilterSheet.toggle()
                            }, label: {
                                Image(systemName: "arrow.up.arrow.down")
                                    
                            })
                            .sheet(isPresented: $showFilterSheet, onDismiss: { showFilterSheet = false } , content: {
                                Text("Filters")
                            })
                        }
                    }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
        PokemonListView().preferredColorScheme(.dark)
    }
}

struct PokemonListGrid: View {
    let pokemon: [Pokemon]
    let searchText: String
    @Binding var showPokemonDetailView: Bool

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 0, content: {
            ForEach(pokemon.filter { "\($0)".contains(searchText) || searchText.isEmpty }, id: \.self) { pokemon in
                NavigationLink(
                    destination: PokemonDetailView(pokemon: pokemon),
                    label: {
                        PokemonListRow(pokemon: pokemon)
                    }).foregroundColor(Color(.label))
            }
        })
    }
}

struct PokemonListRow: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            Image("\(pokemon.id)")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 4)
            Text(pokemon.name)
                .font(.system(size: 16, weight: .regular, design: .monospaced))
            Spacer()
            TypeIcon(typing: pokemon.primaryType)
            if pokemon.secondaryType != nil {
                TypeIcon(typing: pokemon.secondaryType!)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct TypeIcon: View {
    let typing: PokemonTyping

    var body: some View {
        Text(typing.rawValue)
            .font(.system(size: 14, weight: .bold, design: .monospaced))
            .frame(width: 60)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(PokemonUtils.PokemonTypingColor(type: typing))
            .foregroundColor(.white)
            .cornerRadius(6.0)
    }
}

struct SearchBar: View {
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
            .padding(.trailing, isSearching ? 4 : 16)
            .onTapGesture {
                self.isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if (searchText != "") {
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