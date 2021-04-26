//
//  StringDropdownPicker.swift
//  Yapodex
//
//  Created by Mike Bone on 26/04/2021.
//

import SwiftUI

struct StringDropdownPicker: View {
    var title: String
    @Binding var selection: String
    var options: [String]
    
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                Spacer()
                Text(selection)
                    .foregroundColor(Color(.label).opacity(0.6))
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
                    Text("Select \(title)")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color(.label))
                        .padding(.bottom, 8)
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
                        ForEach(options.indices, id: \.self) { index in
                            if options[index] == selection {
                                Text(options[index])
                                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color(.label).opacity(0.2))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = ""
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[index])
                                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .onTapGesture {
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = options[index]
                                            showOptions = false
                                        }
                                    }
                            }
                        }
                    })
                })
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemBackground))
                .foregroundColor(Color(.label))
                .transition(.opacity)
            }
        }
    }
}

//struct StringDropdownPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        StringDropdownPicker(title: "Test", selection: $testString, options: ["One", "Two", "Three", "Four"])
//    }
//}
