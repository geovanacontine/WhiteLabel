//
//  WLNavigatableModifier.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 04/06/22.
//

import SwiftUI

struct NavigatableModifier: ViewModifier {
    
    @State private var isShowingSubview = false
    let navigationAction: WLNavigationAction?

    func body(content: Content) -> some View {
        if navigationAction == nil {
            content
        } else {
            Button {
                isShowingSubview = true
            } label: {
                VStack {
                    NavigationLink(destination: navigationAction?.destination() ?? EmptyView().toAny(),
                                   isActive: $isShowingSubview) { EmptyView() }
                    content
                }
            }
        }
    }
}

extension View {
    func applyNavigation(_ navigationAction: WLNavigationAction?) -> some View {
        modifier(NavigatableModifier(navigationAction: navigationAction))
    }
}
