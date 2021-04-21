//
//  PokemonUtils.swift
//  Yapodex
//
//  Created by Mike Bone on 20/04/2021.
//

import SwiftUI

class PokemonUtils {
    static func PokemonTypingColor(type: PokemonTyping) -> Color {
        switch type {
        case .grass:
            return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case .poison:
            return Color(#colorLiteral(red: 0.3932023037, green: 0, blue: 0.6449120856, alpha: 1))
        case .fire:
            return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case .flying:
            return Color(#colorLiteral(red: 0.6222697334, green: 0.5133365487, blue: 0.9686274529, alpha: 1))
        case .water:
            return Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        case .bug:
            return Color(#colorLiteral(red: 0.7459656958, green: 0.8235294223, blue: 0.2649375466, alpha: 1))
        }
    }
}

