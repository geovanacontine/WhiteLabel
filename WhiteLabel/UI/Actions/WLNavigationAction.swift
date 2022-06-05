//
//  WLNavigationAction.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 04/06/22.
//

import SwiftUI

struct WLNavigationAction: Decodable {
    
    let view: String
    
    func destination() -> AnyView {
        WLGenericView(viewName: view).toAny()
    }
}

struct NavigatableModifier: ViewModifier {
    
    @State private var isShowingSubview = false
    let navigationAction: WLNavigationAction?
    
    private var destination: AnyView {
        navigationAction?.destination() ?? EmptyView().toAny()
    }
    
    func body(content: Content) -> some View {
        if navigationAction == nil {
            content
        } else {
            Button {
                isShowingSubview = true
            } label: {
                VStack {
                    NavigationLink(destination: destination, isActive: $isShowingSubview) { EmptyView() }
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
