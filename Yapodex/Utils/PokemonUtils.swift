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
    
    static func PokemonStatsColor(stat: Int) -> Color {
        switch stat {
        case 0...40:
            return Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        case 40...60:
            return Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        case 60...80:
            return Color(#colorLiteral(red: 1, green: 0.7854062664, blue: 0.1662433349, alpha: 1))
        case 80...100:
            return Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case 100...150:
            return Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        case 150...Int.max:
            return Color(#colorLiteral(red: 0.5127891239, green: 0.05777581376, blue: 0.6734730114, alpha: 1))
        default:
            return Color.white
        }
    }
}

