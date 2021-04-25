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
