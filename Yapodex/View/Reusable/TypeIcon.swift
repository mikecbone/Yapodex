//
//  TypeIcon.swift
//  Yapodex
//
//  Created by Mike Bone on 26/04/2021.
//

import SwiftUI

struct TypeIcon: View {
    let typing: PokemonTyping

    var body: some View {
        Text(typing.rawValue.uppercased())
            .font(.system(size: 14, weight: .bold, design: .monospaced))
            .frame(width: 66)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(PokemonUtils.PokemonTypingColor(type: typing))
            .foregroundColor(.white)
            .cornerRadius(6.0)
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

struct TypeIcon_Previews: PreviewProvider {
    static var previews: some View {
        TypeIcon(typing: PokemonTyping.fire)
            .previewLayout(.sizeThatFits)
    }
}
