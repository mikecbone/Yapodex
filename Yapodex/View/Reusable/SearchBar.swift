//
//  SearchBar.swift
//  Yapodex
//
//  Created by Mike Bone on 27/04/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isSearching = false

    var body: some View {
        HStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.leading, 22)
                    .padding(.trailing, 22)
                    .onTapGesture {
                        self.isSearching = true
                    }
            }
            .padding(12)
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.leading, 16)
            .padding(.trailing, isSearching ? CGFloat(4) : CGFloat(16))
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if searchText != "" {
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                        })
                    }
                }.padding(.horizontal, 22)
                    .foregroundColor(Color(#colorLiteral(red: 0.7494884133, green: 0.7494884133, blue: 0.7566651702, alpha: 1)))
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())

            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing, 16)
                })
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
            }
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
