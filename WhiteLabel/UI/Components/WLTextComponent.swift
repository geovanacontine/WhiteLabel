//
//  WLTextComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI
import Treco

struct WLTextComponent: WLComponent {
    let id = UUID().uuidString
    let data: WLTextDTO?
    let style: WLComponentStyle?
    
    func render() -> AnyView {
        WLTextView(dto: data, style: style).toAny()
    }
}

struct WLTextDTO: Decodable {
    let text: String?
    let font: String?
    let icon: WLImageDTO?
}

struct WLTextView: View {
    let dto: WLTextDTO?
    let style: WLComponentStyle?
    
    private var alignment: WLAlignmentStyle {
        .init(rawValue: style?.bounds?.alignment ?? "") ?? .left
    }
    
    var body: some View {
        HStack {
            HStack {
                WLImageView(dto: dto?.icon)
                Spacer()
                    .frame(width: Spacing.xs.value)
            }
            .isVisible(dto?.icon != nil)
            TrecoText(dto?.text ?? "")
                .textStyle(FontStyle(fromRawValue: dto?.font ?? ""))
        }
        .applySpacing(style?.bounds)
    }
}
