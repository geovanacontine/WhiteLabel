//
//  WLProductSettings.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 05/06/22.
//

import UIKit
import SwiftUI
import Treco

protocol WLProductSettingsProtocol {
    var environment: WLEnvironmentType { get }
    var navigationTitleColor: Color { get }
    var hasNavigationBarShadow: Bool { get }
    
    func setupDesignSystem()
    func setupNavigationBar()
}

final class WLProductSettings: WLProductSettingsProtocol {
    
    static let shared = WLProductSettings()
    private init() {}
    
    var navigationTitleColor: Color {
        let token = TokensManager.shared.getValue("navigationBar_titleColor") ?? "neutralDarkPure"
        return .treco(.init(fromRawValue: token))
    }
    
    var hasNavigationBarShadow: Bool {
        let token = TokensManager.shared.getValue("navigationBar_hasShadow") ?? "false"
        return Bool(token) ?? false
    }
    
    var environment: WLEnvironmentType {
        let token = TokensManager.shared.getValue("environment") ?? "local"
        return .init(rawValue: token) ?? .local
    }
    
    func setupDesignSystem() {
        TokensManager.shared.setTheme(fromJson: "tokens")
        ResourcesManager.configurePackageUI()
    }
    
    func setupNavigationBar() {
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
}
