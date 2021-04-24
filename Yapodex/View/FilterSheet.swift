//
//  FilterSheet.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct FilterSheet: View {
    @Binding var listFilters: Filters
    @State private var showSheet = false

    var body: some View {
        ScrollView {
            TypingFilter(listFilters: $listFilters)
            GenerationFilter()
        }
    }
}

struct FilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

struct TypingFilter: View {
    @Binding var listFilters: Filters

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Typing")
                Spacer()
            }.padding()
                .background(Color(.systemGray5))
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], alignment: .center, spacing: 20, content: {
                ForEach(PokemonTyping.allCases, id: \.self) { type in
                    if listFilters.types.contains(type) {
                        Button(action: {
                            guard let index = listFilters.types.firstIndex(of: type) else { return }
                            listFilters.types.remove(at: index)
                        }, label: {
                            TypeIcon(typing: type)
                        })
                    } else {
                        Button(action: {
                            listFilters.types.append(type)
                        }, label: {
                            TypeIcon(typing: type)
                        }).opacity(0.33)
                            .disabled(listFilters.types.count >= 2)
                    }
                }
            }).padding(.horizontal, 8)
            .padding(.bottom)
        }
    }
}

struct GenerationFilter: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Generation")
                Spacer()
            }.padding()
                .background(Color(.systemGray5))
        }
    }
}
