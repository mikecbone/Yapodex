//
//  PokemonDetail.swift
//  Yapodex
//
//  Created by Mike Bone on 27/04/2021.
//

import Foundation

struct PokemonDetail: Decodable {
    let name: String
    let nationalId: Int
    let types: [PokemonTyping]
    let abilities: [PokemonAbility]
    let genderRatios: PokemonGenderRatio?
    let catchRate: Int
    let eggGroups: [String]
    let hatchTime: [Int]
    let height: String
    let weight: String
    let baseExpYield: Int
    let levelingRate: String
    let evYield: PokemonEvYield
    let color: String
    let baseFriendship: Int
    let baseStats: PokemonBaseStats
    let evolutionFrom: PokemonEvolutionFrom?
    let evolutions: [PokemonEvolutionTo]
    let megaEvolutions: [PokemonMegaEvolutions]
    let categories: String
    let regionIds: PokemonRegionIds
//    let variations: [PokemonVariations]
    let pokedexEntries: PokedexEntries
    let pokeathlonStats: PokeathlonStats
    let ultraAlolaId: Int?
    let moveLearnSets: [PokemonLearnsets]
}

struct PokemonAbility: Decodable, Hashable {
    let name: String
    let hidden: Bool?
}

struct PokemonGenderRatio: Decodable {
    let male, female: Double?
}

struct PokemonEvYield: Decodable  {
    let hp, atk, def, spa, spd, spe: Int
}

struct PokemonEvolutionFrom: Decodable {
    let id: Int
    let name: String
    let types: [PokemonTyping]
}

struct PokemonEvolutionTo: Decodable, Hashable {
    let id: Int
    let name: String
    let types: [PokemonTyping]
    let level: Int?
    let item: String?
    let happiness, level_up: Bool?
    let conditions: [String]?
}

struct PokemonMegaEvolutions: Decodable {
    let types: [PokemonTyping]
    let ability, megaStone, height, weight: String
    let baseStats: PokemonBaseStats
}

struct PokemonRegionIds: Decodable {
    let kanto_id: Int?
    let johto_id: Int?
    let hoenn_id: Int?
    let sinnoh_id: Int?
    let unova_id: Int?
    let kalos_id: Int?
    let alola_id: Int?
}

//struct PokemonVariations {
//
//}

struct PokedexEntries: Decodable {
    let red, blue, yellow, gold, silver, crystal, ruby, sapphire, emerald, fireRed, leafGreen, diamond, pearl, platinum, heartGold, soulSilver, black, white, black2, white2, x, y, omegaRuby, alphaSapphire, sun, moon, ultraSun, ultraMoon: String?
}

struct PokeathlonStats: Decodable {
    let speed, power, stamina, skill, jump: [Int]
}

struct PokemonLearnsets: Decodable {
    let games: [String]
    let learnset: [PokemonMoveset]
}

struct PokemonMoveset: Decodable, Hashable {
    let move: String
    let level: Int?
    let tm: String?
    let egg_move: Bool?
}
