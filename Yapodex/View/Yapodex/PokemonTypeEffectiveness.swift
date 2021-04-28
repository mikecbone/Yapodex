//
//  PokemonTypeEffectiveness.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import SwiftUI

struct PokemonTypeEffectiveness: View {
    let pokemonId: Int
    let pokemonTypes: [PokemonTyping]
    @ObservedObject private var vm = TypeEffectivenessViewModel()

    func GetTypeEffectivenessArray(types: [PokemonTyping]) -> [TypeEffectiveness] {
        var returnArray: [TypeEffectiveness] = []
        for type in types {
            returnArray.append(vm.GetTypeEffectiveness(type: type))
        }
        return returnArray
    }

    var body: some View {
        let combinedTyping = PokemonUtils.CalculateTypeEffectivenessFrom(typeEffectivenesses: GetTypeEffectivenessArray(types: pokemonTypes))

        ScrollView {
            HStack {
                Image("\(pokemonId)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                ForEach(pokemonTypes, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }.padding(.top, 8)
            EffectivenessChart(title: "SUPER WEAK TO", effectiveNumber: "4", types: combinedTyping.quad_damage_from)
            EffectivenessChart(title: "WEAK TO", effectiveNumber: "2", types: combinedTyping.double_damage_from)
            EffectivenessChart(title: "REGULAR TO", effectiveNumber: "1", types: combinedTyping.regular_damage_from)
            EffectivenessChart(title: "RESISTANT TO", effectiveNumber: "\(NSLocalizedString("\u{00BD}", comment: "1/2"))", types: combinedTyping.half_damage_from)
            EffectivenessChart(title: "SUPER RESISTANT TO", effectiveNumber: "\(NSLocalizedString("\u{00BC}", comment: "1/4"))", types: combinedTyping.quarter_damage_from)
            EffectivenessChart(title: "IMMUNE TO", effectiveNumber: "0", types: combinedTyping.no_damage_from)
        }.navigationTitle("Type Effectiveness")
            .navigationBarTitleDisplayMode(.inline)
    }
}

private struct EffectivenessChart: View {
    let title: String
    let effectiveNumber: String
    let types: [PokemonTyping]

    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Text("x \(effectiveNumber)")
            }
            .padding(8)
            .background(Color(.systemGray6))
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], alignment: .center, spacing: 8, content: {
                if types.isEmpty {
                    EmptyTypeIcon()
                } else {
                    ForEach(types, id: \.self) { type in
                        TypeIcon(typing: type)
                    }
                }
            }).padding(.horizontal, 8)
        }.padding(.bottom, 8)
    }
}

struct PokemonTypeEffectiveness_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonTypeEffectiveness(pokemonId: 01, pokemonTypes: [PokemonTyping.grass, PokemonTyping.poison])
        }
    }
}
