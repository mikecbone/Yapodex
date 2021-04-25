//
//  FilterSheet.swift
//  Yapodex
//
//  Created by Mike Bone on 21/04/2021.
//

import SwiftUI

struct FilterSheet: View {
    @Binding var listFilters: Filters
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
//                    Image(systemName: "xmark")
                    Text("Close")
                })
            }.padding()
            ScrollView {
                TypingFilter(listFilters: $listFilters)
                GenerationFilter()
            }
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
            ZStack {
                HStack {
                    Spacer()
                    Text("Typing")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                    Spacer()
                }.padding()
                .background(Color(.systemGray5))
                HStack {
                    Spacer()
                    if listFilters.types.count >= 1 {
                        Button(action: {
                            listFilters.types = []
                        }, label: {
                            Text("Clear")
                        })
                        .padding()
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                    }
                }
            }
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
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                Spacer()
            }.padding()
                .background(Color(.systemGray5))
        }
    }
}
