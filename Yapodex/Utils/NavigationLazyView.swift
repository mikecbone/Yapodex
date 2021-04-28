//
//  NavigationLazyView.swift
//  Yapodex
//
//  Created by Mike Bone on 28/04/2021.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
