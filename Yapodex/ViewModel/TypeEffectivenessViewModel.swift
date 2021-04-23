//
//  TypeEffectivenessViewModel.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import Foundation

class TypeEffectivenessViewModel: ObservableObject {
    @Published var typeEffectiveness: PokemonDataTypeEffectiveness?
    
    init() {
        guard let typeEffectivenessPath = Bundle.main.url(forResource: "KantoTypeEffectiveness", withExtension: "json") else { return }
        DispatchQueue.main.async {
            do {              
                let typeEffectivenessData = try Data(contentsOf: typeEffectivenessPath)
                self.typeEffectiveness = try JSONDecoder().decode(PokemonDataTypeEffectiveness.self, from: typeEffectivenessData)
            } catch {
                print(error)
            }
        }
    }
    
    func GetTypeEffectiveness(type: PokemonTyping) -> TypeEffectiveness {
        guard let typeEffectiveness = self.typeEffectiveness?.type_effectiveness else {
            return TypeEffectiveness(double_damage_from: [], double_damage_to: [], half_damage_from: [], half_damage_to: [], no_damage_from: [], no_damage_to: [])
        }
        
        switch type {
        case .normal:
            return typeEffectiveness.normal
        case .fire:
            return typeEffectiveness.fire
        case .fighting:
            return typeEffectiveness.fighting
        case .water:
            return typeEffectiveness.water
        case .flying:
            return typeEffectiveness.flying
        case .grass:
            return typeEffectiveness.grass
        case .poison:
            return typeEffectiveness.poison
        case .electric:
            return typeEffectiveness.electric
        case .ground:
            return typeEffectiveness.ground
        case .psychic:
            return typeEffectiveness.psychic
        case .rock:
            return typeEffectiveness.rock
        case .ice:
            return typeEffectiveness.ice
        case .bug:
            return typeEffectiveness.bug
        case .dragon:
            return typeEffectiveness.dragon
        case .ghost:
            return typeEffectiveness.ghost
        case .dark:
            return typeEffectiveness.dark
        case .steel:
            return typeEffectiveness.steel
        case .fairy:
            return typeEffectiveness.fairy
        }
    }
}
