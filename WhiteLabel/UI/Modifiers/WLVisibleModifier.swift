//
//  WLVisibleModifier.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 03/06/22.
//

import SwiftUI

struct VisibleModifier: ViewModifier {
    let isVisible: Bool

    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                EmptyView()
            }
        }
    }
}

extension View {
    func isVisible(_ isVisible: Bool) -> some View {
        modifier(VisibleModifier(isVisible: isVisible))
    }
}
