//
//  WLImageComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 07/06/22.
//

import SwiftUI
import Treco

struct WLImageComponent: WLComponent {
    let tag: String?
    let data: WLImageDTO?
    let style: WLComponentStyle?
    let onTap: WLNavigationAction?
    
    func render() -> AnyView {
        WLImageView(dto: .init(name: nil,
                               size: nil,
                               url: data?.url,
                               width: nil,
                               height: data?.height,
                               border: data?.border,
                               tintColor: nil,
                               isDynamicWidth: true))
            .applySpacing(style?.bounds)
            .applyNavigation(onTap)
            .toAny()
    }
}
