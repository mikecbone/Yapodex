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
    
    func getPokemonGenerationStrings() -> [String] {
        var returnArray: [String] = []
        for generation in PokemonGenerationFilter.allCases {
            if generation.rawValue.isEmpty { continue }
            returnArray.append(generation.rawValue)
        }
        return returnArray
    }
    
    func getPokemonEvStrings() -> [String] {
        var returnArray: [String] = []
        for ev in PokemonEvFilter.allCases {
            if ev.rawValue.isEmpty { continue }
            returnArray.append(ev.rawValue)
        }
        return returnArray
    }

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Filters")
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                }.padding()
                TypingFilter(listFilters: $listFilters)
                Divider()
                    .padding(.horizontal)
                StringDropdownPicker(title: "Generation", selection: $listFilters.generation, options: getPokemonGenerationStrings())
                Divider()
                    .padding(.horizontal)
                StringDropdownPicker(title: "EV Yield", selection: $listFilters.evYield, options: getPokemonEvStrings())
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Confirm")
                }).padding()
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
    let selectionFeedback = UISelectionFeedbackGenerator()

    var body: some View {
        ZStack {
            HStack {
                Text("Types")
                Spacer()
                ForEach(listFilters.types, id: \.self) { type in
                    Text(type.rawValue)
                        .foregroundColor(Color(.label).opacity(0.6))
                }
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
            }
            .font(.system(size: 16, weight: .medium, design: .monospaced))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            .onTapGesture {
                withAnimation(Animation.spring().speed(2)) {
                    showOptions.toggle()
                }
            }
            if showOptions {
                VStack(alignment: .leading, spacing: 4, content: {
                    Text("Select Types")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color(.label))
                        .padding(.bottom)
                        .onTapGesture {
                            withAnimation(Animation.spring().speed(2)) {
                                showOptions.toggle()
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
                                    if (listFilters.types.count == 0) {
                                        withAnimation(Animation.spring().speed(2)) {
                                            selectionFeedback.selectionChanged()
                                            showOptions = false
                                        }
                                    }
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
                                    if (listFilters.types.count == 2) {
                                        withAnimation(Animation.spring().speed(2)) {
                                            selectionFeedback.selectionChanged()
                                            showOptions = false
                                        }
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
