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
}

struct WLTextView: View {
    let dto: WLTextDTO?
    let style: WLComponentStyle?
    
    private var alignment: WLAlignmentStyle {
        .init(rawValue: style?.bounds?.alignment ?? "") ?? .left
    }
    
    var body: some View {
        TrecoText(dto?.text ?? "")
            .textStyle(FontStyle(fromRawValue: dto?.font ?? ""))
            .applySpacing(style?.bounds)
    }
}
