//
//  PokedexViewModel.swift
//  Yapodex
//
//  Created by Mike Bone on 22/04/2021.
//

import Foundation

class PokedexViewModel: ObservableObject {
    @Published var pokedex: PokemonDataPokedex?
    
    init() {
        guard let pokedexPath = Bundle.main.url(forResource: "KantoPokedex", withExtension: "json") else { return }
        DispatchQueue.main.async {
            do {
                let pokedexData = try Data(contentsOf: pokedexPath)
                self.pokedex = try JSONDecoder().decode(PokemonDataPokedex.self, from: pokedexData)
            } catch {
                print(error)
            }
        }
    }
}
