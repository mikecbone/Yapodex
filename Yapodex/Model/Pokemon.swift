//
//  Pokemon.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import Foundation

struct Pokemon: Hashable {
    let id: Int
    let name: String
    let primaryType: PokemonTyping
    let secondaryType: PokemonTyping?
}
