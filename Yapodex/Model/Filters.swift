//
//  Filters.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import Foundation

struct Filters {
    var types: [PokemonTyping]
    var ordering: SortOrdering
    var isAscending: Bool
    var generation: String
    var evYield: String
}

enum SortOrdering: String {
    case numerical = "numerical"
    case alphabetical = "alphabetical"
    case hpstat = "hp"
    case atkstat = "atk"
    case defstat = "def"
    case spastat = "spa"
    case spdstat = "spd"
    case spestat = "spe"
}

enum PokemonGenerationFilter: String, CaseIterable {
    case gen1 = "Gen 1"
    case gen2 = "Gen 2"
    case gen3 = "Gen 3"
    case gen4 = "Gen 4"
    case gen5 = "Gen 5"
    case gen6 = "Gen 6"
    case gen7 = "Gen 7"
    case gen8 = "Gen 8"
    case none = ""
}

enum PokemonEvFilter: String, CaseIterable {
    case hp = "HP"
    case atk = "ATK"
    case def = "DEF"
    case spa = "SPA"
    case spd = "SPD"
    case spe = "SPE"
    case none = ""
}
