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
}

enum SortOrdering: String {
    case numerical = "numerical"
    case alphabetical = "alphabetical"
}
