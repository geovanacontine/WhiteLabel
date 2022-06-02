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
        TokensManager.shared.setTheme(fromJson: "tokens")
    }
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .preferredColorScheme(.light)
        }
    }
}
