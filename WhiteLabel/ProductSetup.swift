//
//  ProductSetup.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 05/06/22.
//

import UIKit
import Treco

struct ProductSetup {
    static func setupDesignSystem() {
        TokensManager.shared.setTheme(fromJson: "tokens")
        ResourcesManager.configurePackageUI()
    }
    
    static func setupNavigationBar() {
        let dto = ProductSettings.shared.navigationBarAppearance
        let barStyle = WLStatusBarStyle(rawValue: dto.statusBarStyle ?? "") ?? .light
        let backgroundColor = UIColor.treco(.init(fromRawValue: dto.backgroundColor ?? ""))
        let tintColor = UIColor.treco(.init(fromRawValue: dto.titleColor ?? ""))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UIApplication.shared.statusBarStyle = barStyle.systemStyle
    }
}
