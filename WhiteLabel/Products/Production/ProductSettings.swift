//
//  ProductSettings.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 04/06/22.
//

import Foundation

final class ProductSettings {
    
    static let shared = ProductSettings()
    
    private(set) var shouldDelayRequests = false
    private(set) var navigationBarAppearance: WLNavigationBarAppearance
    
    private init() {
        navigationBarAppearance = .init(titleColor: "neutralDarkPure",
                                        backgroundColor: "neutralLightPure",
                                        statusBarStyle: "dark")
    }
}
