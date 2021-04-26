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
    @State private var typeSelection: PokemonTyping = PokemonTyping.normal

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Close")
                })
            }.padding()
            ScrollView {
                HStack {
                    Text("Filters")
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                }
                TypingFilter(listFilters: $listFilters)
                Divider()
                    .padding(.horizontal)
                StringDropdownPicker(title: "Generation", selection: $listFilters.generation, options: ["Gen 1", "Gen 2", "Gen 3", "Gen 4", "Gen 5", "Gen 6", "Gen 7", "Gen 8"])
                Divider()
                    .padding(.horizontal)
                StringDropdownPicker(title: "EV Yield", selection: $listFilters.evYield, options: ["HP", "ATK", "DEF", "SPA", "SPD", "SPE"])
            }
        }
    }
}

struct FilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

private struct TypingFilter: View {
    @Binding var listFilters: Filters
    @State private var showOptions: Bool = false

    var body: some View {
        ZStack {
            HStack {
                Text("Types")
                Spacer()
                ForEach(listFilters.types, id: \.self) { type in
                    Text(type.rawValue)
                        .foregroundColor(Color.black.opacity(0.6))
                }
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
            }
            .font(.system(size: 16, weight: .medium, design: .monospaced))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .onTapGesture {
                withAnimation(Animation.spring().speed(2)) {
                    showOptions = true
                }
            }
            if showOptions {
                VStack(alignment: .leading, spacing: 4, content: {
                    Text("Types")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color(.label))
                        .padding(.bottom)
                    LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                    ], alignment: .center, spacing: 20, content: {
                        ForEach(PokemonTyping.allCases, id: \.self) { type in
                            if listFilters.types.contains(type) {
                                Button(action: {
                                    withAnimation(Animation.spring().speed(2)) {
                                        showOptions = false
                                    }
                                    guard let index = listFilters.types.firstIndex(of: type) else { return }
                                    listFilters.types.remove(at: index)
                                }, label: {
                                    TypeIcon(typing: type)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6.0)
                                                .stroke(Color(.label), lineWidth: 4)
                                        )
                                })
                            } else {
                                Button(action: {
                                    listFilters.types.append(type)
                                    withAnimation(Animation.spring().speed(2)) {
                                        showOptions = false
                                    }
                                }, label: {
                                    TypeIcon(typing: type)
                                }).disabled(listFilters.types.count >= 2)
                            }
                        }
                    })
                })
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemBackground))
                .foregroundColor(.white)
                .transition(.opacity)
            }
        }
    }
}
