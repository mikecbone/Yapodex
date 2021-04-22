//
//  Pokemon.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import Foundation

struct PokemonData: Decodable, Hashable {
    let pokedex: [Pokemon]
}

struct Pokemon: Decodable, Hashable {
    let id: Int
    let name: String
    let type: [PokemonTyping]
    let base: PokemonBaseStats
}

enum PokemonTyping: String, Decodable {
    case grass = "grass"
    case poison = "poison"
    case fire = "fire"
    case flying = "flying"
    case water = "water"
    case bug = "bug"
}

struct PokemonBaseStats: Decodable, Hashable {
    let HP, ATK, DEF, SPA, SPD, SPE: Int
}
