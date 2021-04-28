//
//  DetailedPokemonViewModel.swift
//  Yapodex
//
//  Created by Mike Bone on 27/04/2021.
//

import Foundation

class DetailedPokemonViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetail = PokemonDetail(name: "", nationalId: 0, types: [], abilities: [], genderRatios: PokemonGenderRatio(male: 0.0, female: 0.0), catchRate: 0, eggGroups: [], hatchTime: [], height: "", weight: "", baseExpYield: 0, levelingRate: "", evYield: PokemonEvYield(hp: 0, atk: 0, def: 0, spa: 0, spd: 0, spe: 0), color: "", baseFriendship: 0, baseStats: PokemonBaseStats(hp: 0, atk: 0, def: 0, spa: 0, spd: 0, spe: 0), evolutionFrom: PokemonEvolutionFrom(id: 1, name: "", types: []), evolutions: [], megaEvolutions: [], categories: "", regionIds: PokemonRegionIds(kanto_id: 0, johto_id: 0, hoenn_id: 0, sinnoh_id: 0, unova_id: 0, kalos_id: 0, alola_id: 0), pokedexEntries: PokedexEntries(red: "", blue: "", yellow: "", gold: "", silver: "", crystal: "", ruby: "", sapphire: "", emerald: "", fireRed: "", leafGreen: "", diamond: "", pearl: "", platinum: "", heartGold: "", soulSilver: "", black: "", white: "", black2: "", white2: "", x: "", y: "", omegaRuby: "", alphaSapphire: "", sun: "", moon: "", ultraSun: "", ultraMoon: ""), pokeathlonStats: PokeathlonStats(speed: [], power: [], stamina: [], skill: [], jump: []), ultraAlolaId: 0, moveLearnSets: [PokemonLearnsets(games: [], learnset: [])])

    init(name: String) {
        getPokemon(name: name)
    }
    
    func getPokemon(name: String) {
        guard let pokemonPath = Bundle.main.url(forResource: "\(name.lowercased())", withExtension: "json") else { return }
        DispatchQueue.main.async {
            do {
                let pokemonData = try Data(contentsOf: pokemonPath)
                self.pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: pokemonData)
            } catch {
                print(error)
            }
        }
    }
}
