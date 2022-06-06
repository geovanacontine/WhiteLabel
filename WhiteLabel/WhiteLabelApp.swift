//
//  WhiteLabelApp.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI
import Treco

@main
struct WhiteLabelApp: App {
    
    init() {
        WLProductSettings.shared.setupDesignSystem()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WLGenericView(viewName: WLLocalView.home.rawValue)
                    .preferredColorScheme(.light)
                    .onAppear {
                        WLProductSettings.shared.setupNavigationBar()
                    }
            }
            .accentColor(.treco(.brandPure))
        }
    }
}
