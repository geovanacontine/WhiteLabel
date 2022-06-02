//
//  WLVerticalSpacingComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 29/05/22.
//

import SwiftUI
import Treco

struct WLVerticalSpacingComponent: WLComponent {
    let id = UUID().uuidString
    let data: WLVerticalSpacingDTO?
    let style: WLComponentStyle?
    
    func render() -> AnyView {
        WLVerticalSpacingView(dto: data, style: style).toAny()
    }
}

struct WLVerticalSpacingDTO: Decodable {
    let value: String?
    let color: String?
}

struct WLVerticalSpacingView: View {
    let dto: WLVerticalSpacingDTO?
    let style: WLComponentStyle?
    
    private var color: Color {
        Color.treco(.init(fromRawValue: dto?.color ?? ""))
    }
    
    private var height: CGFloat {
        Spacing(fromRawValue: dto?.value ?? "").value
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .applySpacing(style?.bounds)
    }
}
