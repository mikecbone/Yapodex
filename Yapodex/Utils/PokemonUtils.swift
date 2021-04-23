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
        case .normal:
            return Color(#colorLiteral(red: 0.658501327, green: 0.658501327, blue: 0.4718124866, alpha: 1))
        case .fire:
            return Color(#colorLiteral(red: 0.9421718717, green: 0.5031989217, blue: 0.1866790652, alpha: 1))
        case .fighting:
            return Color(#colorLiteral(red: 0.7530786395, green: 0.1866790652, blue: 0.1580777168, alpha: 1))
        case .water:
            return Color(#colorLiteral(red: 0.4077255726, green: 0.5648300052, blue: 0.9421718717, alpha: 1))
        case .flying:
            return Color(#colorLiteral(red: 0.658501327, green: 0.5648300052, blue: 0.9421718717, alpha: 1))
        case .grass:
            return Color(#colorLiteral(red: 0.4718124866, green: 0.7852324843, blue: 0.3118663132, alpha: 1))
        case .poison:
            return Color(#colorLiteral(red: 0.6288433671, green: 0.2507202923, blue: 0.6288433671, alpha: 1))
        case .electric:
            return Color(#colorLiteral(red: 0.9728776813, green: 0.8171131611, blue: 0.1866790652, alpha: 1))
        case .ground:
            return Color(#colorLiteral(red: 0.8801110387, green: 0.7530786395, blue: 0.4077255726, alpha: 1))
        case .psychic:
            return Color(#colorLiteral(red: 0.9728776813, green: 0.3457817435, blue: 0.5341949463, alpha: 1))
        case .rock:
            return Color(#colorLiteral(red: 0.7206355929, green: 0.6288433671, blue: 0.2191196382, alpha: 1))
        case .ice:
            return Color(#colorLiteral(red: 0.5951295495, green: 0.8487350345, blue: 0.8487350345, alpha: 1))
        case .bug:
            return Color(#colorLiteral(red: 0.658501327, green: 0.7206355929, blue: 0.1235707179, alpha: 1))
        case .dragon:
            return Color(#colorLiteral(red: 0.4400013685, green: 0.2191196382, blue: 0.9728776813, alpha: 1))
        case .ghost:
            return Color(#colorLiteral(red: 0.4400013685, green: 0.3457817435, blue: 0.5951295495, alpha: 1))
        case .dark:
            return Color(#colorLiteral(red: 0.4400013685, green: 0.3457817435, blue: 0.2816046476, alpha: 1))
        case .steel:
            return Color(#colorLiteral(red: 0.7206355929, green: 0.7206355929, blue: 0.8171131611, alpha: 1))
        case .fairy:
            return Color(#colorLiteral(red: 1, green: 0.3954927921, blue: 0.8347119689, alpha: 1))
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

