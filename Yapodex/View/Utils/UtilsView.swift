//
//  UtilsView.swift
//  Yapodex
//
//  Created by Mike Bone on 25/04/2021.
//

import SwiftUI

struct UtilsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: nil)], alignment: .center, spacing: 8, content: {
                    TypeCheckerRow()
                    Divider().padding(.horizontal, 8)
                    TeamBuilderRow()
                    Divider().padding(.horizontal, 8)
                    ComparePokemonRow()
                    Divider().padding(.horizontal, 8)
                    FavouritePokemonRow()
                }).padding(.top)
            }.navigationTitle("Utilities")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UtilsView_Previews: PreviewProvider {
    static var previews: some View {
        UtilsView()
    }
}

private struct TypeCheckerRow: View {
    var body: some View {
        NavigationLink(
            destination: TypeEffectivenessList(),
            label: {
                HStack {
                    Image(systemName: "square.slash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Type Checker")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        ).foregroundColor(Color(.label))
    }
}

private struct TeamBuilderRow: View {
    var body: some View {
        NavigationLink(
            destination: Text("Hello"),
            label: {
                HStack {
                    Image(systemName: "square.split.2x2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Team Builder")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        ).foregroundColor(Color(.label))
    }
}

private struct ComparePokemonRow: View {
    var body: some View {
        NavigationLink(
            destination: Text("Hello"),
            label: {
                HStack {
                    Image(systemName: "square.split.2x1.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Compare Pokemon")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        ).foregroundColor(Color(.label))
    }
}

private struct FavouritePokemonRow: View {
    var body: some View {
        NavigationLink(
            destination: Text("Hello"),
            label: {
                HStack {
                    Image(systemName: "star.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Favourites")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        ).foregroundColor(Color(.label))
    }
}
