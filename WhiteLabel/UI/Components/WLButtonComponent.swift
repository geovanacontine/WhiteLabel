//
//  WLButtonComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 07/06/22.
//

import SwiftUI
import Treco

struct WLButtonComponent: WLComponent {
    let tag: String?
    let data: WLButtonDTO?
    let style: WLComponentStyle?
    
    func render() -> AnyView {
        WLButtonView(dto: data, style: style).toAny()
    }
}

struct WLButtonDTO: Decodable {
    let title: String?
    let type: String?
}

struct WLButtonView: View {
    let dto: WLButtonDTO?
    let style: WLComponentStyle?
    
    private var type: WLButtonType {
        .init(rawValue: dto?.type ?? "") ?? .primary
    }
    
    var body: some View {
        Button {
            print()
        } label: {
            TrecoText(dto?.title ?? "")
                .textStyle(.heading4, color: type.fontColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(type.backgroundColor)
                .addBorder(radius: .medium,
                           width: type.borderWidth,
                           color: .brandPure)
                .applySpacing(style?.bounds)
        }
    }
}
