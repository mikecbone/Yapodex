//
//  Pokemon.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import Foundation

struct PokemonDataPokedex: Decodable, Hashable {
    let pokedex: [Pokemon]
}

struct Pokemon: Decodable, Hashable {
    let id: Int
    let name: String
    let type: [PokemonTyping]
    let base: PokemonBaseStats
}

enum PokemonTyping: String, Decodable, CaseIterable {
    case normal = "normal"
    case fire = "fire"
    case fighting = "fight"
    case water = "water"
    case flying = "flying"
    case grass = "grass"
    case poison = "poison"
    case electric = "electr"
    case ground = "ground"
    case psychic = "psychic"
    case rock = "rock"
    case ice = "ice"
    case bug = "bug"
    case dragon = "dragon"
    case ghost = "ghost"
    case dark = "dark"
    case steel = "steel"
    case fairy = "fairy"
}

struct PokemonBaseStats: Decodable, Hashable {
    let HP, ATK, DEF, SPA, SPD, SPE: Int
}

struct PokemonDataTypeEffectiveness: Decodable, Hashable {
    let type_effectiveness: Type
}

struct Type: Decodable, Hashable {
    let normal, fighting, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electric, psychic, ice, dragon, dark, fairy: TypeEffectiveness
}

struct TypeEffectiveness: Decodable, Hashable {
    let double_damage_from, double_damage_to, half_damage_from, half_damage_to, no_damage_from, no_damage_to: [PokemonTyping]
}

struct TypeEffectivenessFrom: Hashable {
    var no_damage_from, quarter_damage_from, half_damage_from, regular_damage_from, double_damage_from, quad_damage_from: [PokemonTyping]
}
