//
//  PokemonViewModel.swift
//  Yapodex
//
//  Created by Mike Bone on 22/04/2021.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemonData: PokemonData?
    
    init() {
        guard let path = Bundle.main.url(forResource: "KantoData", withExtension: "json") else { return }
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: path)
                self.pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
