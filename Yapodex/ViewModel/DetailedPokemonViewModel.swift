//
//  DetailedPokemonViewModel.swift
//  Yapodex
//
//  Created by Mike Bone on 27/04/2021.
//

import Foundation

class DetailedPokemonViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDataPokedex?
    
    init() {
        guard let pokemonPath = Bundle.main.url(forResource: "Pokedex", withExtension: "json") else { return }
        DispatchQueue.main.async {
            do {
                let pokemonData = try Data(contentsOf: pokemonPath)
                self.pokemonDetail = try JSONDecoder().decode(PokemonDataPokedex.self, from: pokemonData)
            } catch {
                print(error)
            }
        }
    }
}
