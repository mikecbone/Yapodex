//
//  TypeEffectivenessList.swift
//  Yapodex
//
//  Created by Mike Bone on 23/04/2021.
//

import SwiftUI

struct TypeEffectivenessList: View {
    @ObservedObject private var vm = TypeEffectivenessViewModel()
    @State private var displayMode = "super"
    
    var body: some View {
        VStack {
            Picker("type", selection: $displayMode)  {
                Text("Super").tag("super")
                Text("Resistant").tag("resistant")
                Text("Immune").tag("immune")
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 8)
            .padding(.horizontal)
            ScrollView {
                ForEach(PokemonTyping.allCases, id: \.self) { type in
                    if (displayMode == "super") {
                        SuperEffectiveView(main: type, typeEffectiveness: vm.GetTypeEffectiveness(type: type))
                    } else if (displayMode == "resistant") {
                        ResistantEffectiveView(main: type, typeEffectiveness: vm.GetTypeEffectiveness(type: type))
                    } else {
                        ImmuneEffectiveView(main: type, typeEffectiveness: vm.GetTypeEffectiveness(type: type))
                    }
                    Divider()
                }
            }
        }.navigationTitle("Type Effectiveness")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TypeEffectivenessList_Previews: PreviewProvider {
    static var previews: some View {
        TypeEffectivenessList()
        TypeEffectivenessList().preferredColorScheme(.dark)
    }
}

struct SuperEffectiveView: View {
    let main: PokemonTyping
    let typeEffectiveness: TypeEffectiveness
    
    var body: some View {
        HStack {
            VStack {
                if (typeEffectiveness.double_damage_from.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.double_damage_from, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("x2")
            }
            Spacer()
            TypeIcon(typing: main)
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("x2")
            }
            Spacer()
            VStack {
                if (typeEffectiveness.double_damage_to.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.double_damage_to, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
        }.padding(.horizontal, 8)
        .padding(.vertical)
    }
}

struct ResistantEffectiveView: View {
    let main: PokemonTyping
    let typeEffectiveness: TypeEffectiveness
    
    var body: some View {
        HStack {
            VStack {
                if (typeEffectiveness.half_damage_from.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.half_damage_from, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("\(NSLocalizedString("\u{00BD}", comment: "1/2"))")
            }
            Spacer()
            TypeIcon(typing: main)
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("\(NSLocalizedString("\u{00BD}", comment: "1/2"))")
            }
            Spacer()
            VStack {
                if (typeEffectiveness.half_damage_to.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.half_damage_to, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
        }.padding(.horizontal, 8)
        .padding(.vertical)
    }
}

struct ImmuneEffectiveView: View {
    let main: PokemonTyping
    let typeEffectiveness: TypeEffectiveness
    
    var body: some View {
        HStack {
            VStack {
                if (typeEffectiveness.no_damage_from.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.no_damage_from, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("x0")
            }
            Spacer()
            TypeIcon(typing: main)
            Spacer()
            VStack {
                Image(systemName: "arrow.right")
                Text("x0")
            }
            Spacer()
            VStack {
                if (typeEffectiveness.no_damage_to.count == 0) {
                    EmptyTypeIcon()
                }
                ForEach(typeEffectiveness.no_damage_to, id: \.self) { type in
                    TypeIcon(typing: type)
                }
            }
        }.padding(.horizontal, 8)
        .padding(.vertical)
    }
}
