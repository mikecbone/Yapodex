//
//  FilterSheet.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct FilterSheet: View {
    @Binding var listFilters: Filters
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Type")
            }.padding()
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], alignment: .center, spacing: 20, content: {
                ForEach(PokemonTyping.allCases, id: \.self) { type in
                    if (listFilters.types.contains(type)) {
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
                    }
                }
            }).padding(.horizontal, 8)
        }
    }
}

struct FilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
