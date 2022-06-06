//
//  WLNavigationAction.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 04/06/22.
//

import SwiftUI
import Treco

struct WLNavigationAction: Decodable {
    
    let view: String
    let isModal: Bool?
    
    func destination() -> AnyView {
        if isModal ?? false {
            return NavigationView { WLGenericView(viewName: view) }
            .accentColor(.treco(.brandPure))
            .toAny()
        } else {
            return WLGenericView(viewName: view).toAny()
        }
    }
}

struct NavigatableModifier: ViewModifier {
    
    @State private var isShowingSubview = false
    let navigationAction: WLNavigationAction?
    
    private var destination: AnyView {
        navigationAction?.destination() ?? EmptyView().toAny()
    }
    
    private var isModal: Bool {
        navigationAction?.isModal ?? false
    }
    
    func body(content: Content) -> some View {
        if navigationAction == nil {
            content
        } else {
            Button {
                isShowingSubview = true
            } label: {
                VStack {
                    if isModal {
                        content
                            .sheet(isPresented: $isShowingSubview) { destination }
                    } else {
                        NavigationLink(destination: destination, isActive: $isShowingSubview) { EmptyView() }
                        content
                    }
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
