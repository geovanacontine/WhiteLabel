//
//  WhiteLabelApp.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI

@main
struct WhiteLabelApp: App {
    
    init() {
        ProductSetup.setupDesignSystem()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WLGenericView(viewName: "home")
                    .preferredColorScheme(.light)
                    .onAppear {
                        ProductSetup.setupNavigationBar()
                    }
            }
        }
    }
}
