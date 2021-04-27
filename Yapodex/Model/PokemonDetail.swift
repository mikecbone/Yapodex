//
//  PokemonDetail.swift
//  Yapodex
//
//  Created by Mike Bone on 27/04/2021.
//

import Foundation

struct PokemonDetail {
    let names: [PokemonName]
    let national_id: Int
    let types: [PokemonTyping]
    let abilities: [PokemonAbility]
    let gender_ratios: [PokemonGenderRatio]
    let catch_rate: Int
    let egg_groups: [PokemonEggGroup]
    let hatch_time: [Int]
    let height: Int
    let weight: Int
    let base_exp_yield: Int
    let leveling_rate: [PokemonLevelingRate]
    let ev_yield: PokemonEvYield
    let color: String
    let base_friendship: Int
    let base_stats: [PokemonBaseStats]
    let evolution_from: String
    let categories: PokemonCategory
    let kanto_id: Int?
    let johto_id: Int?
    let hoenn_id: Int?
    let sinnoh_id: Int?
    let unova_id: Int?
    let kalos_id: Int?
    let alola_id: Int?
    let mega_evolutions: [PokemonMegaEvolutions]
    let evolutions: [PokemonEvolutions]
    let variations: [PokemonVariations]
    let pokedex_entries: [PokemonPokedexEntries]
    let pokeathlon_stats: [PokeathlonStats]
    let ultra_alola_id: Int?
    let move_learnsets: [PokemonLearnsets]
}

  
