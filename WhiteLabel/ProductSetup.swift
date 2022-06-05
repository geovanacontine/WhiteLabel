//
//  ProductSetup.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 05/06/22.
//

import UIKit
import SwiftUI
import Treco

struct ProductSetup {
    static func setupDesignSystem() {
        TokensManager.shared.setTheme(fromJson: "tokens")
        ResourcesManager.configurePackageUI()
    }
    
    static func setupNavigationBar() {
        let manager = TokensManager.shared
        let styleToken = manager.getValue("navigationBar_statusBarStyle") ?? "dark"
        let backgroundToken = manager.getValue("navigationBar_backgroundColor") ?? "neutralLightPure"
        let tintColorToken = manager.getValue("navigationBar_titleColor") ?? "neutralDarkPure"
        
        let barStyle = WLStatusBarStyle(rawValue: styleToken) ?? .light
        let backgroundColor = UIColor.treco(.init(fromRawValue: backgroundToken))
        let tintColor = UIColor.treco(.init(fromRawValue: tintColorToken))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UIApplication.shared.statusBarStyle = barStyle.systemStyle
    }
    
    static var navigationTitleColor: Color {
        let token = TokensManager.shared.getValue("navigationBar_titleColor") ?? "neutralDarkPure"
        return .treco(.init(fromRawValue: token))
    }
    
    static var shouldDelayRequests: Bool {
        let token = TokensManager.shared.getValue("network_shouldDelayRequests") ?? "false"
        return Bool(token) ?? false
    }
}
