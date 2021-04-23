//
//  PokemonTypeEffectiveness.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import SwiftUI

struct PokemonTypeEffectiveness: View {
    let pokemon: Pokemon
    @ObservedObject private var vm = TypeEffectivenessViewModel()
    
    func GetTypeEffectivenessArray(types: [PokemonTyping]) -> [TypeEffectiveness] {
        var returnArray: [TypeEffectiveness] = []
        for type in types  {
            returnArray.append(vm.GetTypeEffectiveness(type: type))
        }
        return returnArray
    }
    
    var body: some View {
        let combinedTyping = PokemonUtils.CalculateTypeEffectivenessFrom(typeEffectivenesses: GetTypeEffectivenessArray(types: pokemon.type))
        
        ScrollView {
            HStack {
                Image("\(pokemon.id)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                ForEach(pokemon.type, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            EffectivenessChart(title: "SUPER WEAK TO:", types: combinedTyping.quad_damage_from)
            EffectivenessChart(title: "WEAK TO:", types: combinedTyping.double_damage_from)
            EffectivenessChart(title: "REGULAR TO:", types: combinedTyping.regular_damage_from)
            EffectivenessChart(title: "RESISTANT TO:", types: combinedTyping.half_damage_from)
            EffectivenessChart(title: "SUPER RESISTANT TO:", types: combinedTyping.quarter_damage_from)
        }.navigationTitle("Type Effectiveness")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct EmptyTypeIcon: View {
    var body: some View {
        Text("NONE")
            .font(.system(size: 14, weight: .bold, design: .monospaced))
            .frame(width: 66)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
            .foregroundColor(.white)
            .cornerRadius(6.0)
    }
}

struct PokemonTypeEffectiveness_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            PokemonTypeEffectiveness(
                pokemon: .init(
                    id: 1, name: "Bulbasaur", type: [PokemonTyping.grass, PokemonTyping.poison], base: PokemonBaseStats(
                        HP: 50, ATK: 50, DEF: 50, SPA: 50, SPD: 50, SPE: 50
                    )
                )
            )
        }
    }
}

struct EffectivenessChart: View {
    let title: String
    let types: [PokemonTyping]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(title)
                Spacer()
                Image(systemName: "help")
                Spacer()
            }
            .padding(8)
                .background(Color(.systemGray6))
            LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
            ], alignment: .center, spacing: 8, content: {
                if (types.count == 0) {
                    EmptyTypeIcon()
                } else {
                    ForEach(types, id: \.self) { type in
                        TypeIcon(typing: type)
                    }
                }
            }).padding(8)
        }
    }
}
