//
//  WLNavigationBarModifier.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 30/05/22.
//

import SwiftUI
import Treco

struct WLNavigationBarDTO: Decodable {
    let title: String?
    let titleColor: String?
    let backgroundColor: String?
    let statusBarStyle: String?
}

struct WLNavigationBarModifier: ViewModifier {
    let dto: WLNavigationBarDTO
    
    private var titleColor: UIColor {
        guard let titleColor = dto.titleColor else {
            return .treco(.neutralDarkPure)
        }
        
        return .treco(.init(fromRawValue: titleColor))
    }
    
    init(dto: WLNavigationBarDTO) {
        self.dto = dto
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .treco(.init(fromRawValue: dto.backgroundColor ?? ""))
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let barStyle = WLStatusBarStyle(rawValue: dto.statusBarStyle ?? "") ?? .light
        UIApplication.shared.statusBarStyle = barStyle.systemStyle
    }
    
    func body(content: Content) -> some View {
        NavigationView {
            content
                .navigationTitle(dto.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension View {
    func setupNavigationBar(dto: WLNavigationBarDTO) -> some View {
        modifier(WLNavigationBarModifier(dto: dto))
    }
}
