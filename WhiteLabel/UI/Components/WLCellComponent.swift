//
//  WLCellComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 29/05/22.
//

import SwiftUI
import Treco

struct WLCellComponent: WLComponent {
    let id = UUID().uuidString
    let data: WLCellDTO?
    let style: WLComponentStyle?
    
    func render() -> AnyView {
        WLCellView(dto: data, style: style).toAny()
    }
}

struct WLCellDTO: Decodable {
    let title: String?
    let value: String?
    let hasSeparator: Bool?
}

struct WLCellView: View {
    let dto: WLCellDTO?
    let style: WLComponentStyle?
    
    var body: some View {
        VStack {
            HStack {
                TrecoText(dto?.title ?? "")
                    .textStyle(.body)
                Spacer()
                TrecoText(dto?.value ?? "")
                    .textStyle(.body)
            }
            if dto?.hasSeparator ?? true {
                Rectangle()
                    .fill(.quaternary)
                    .frame(height: 1)
                Spacer()
                    .frame(height: Spacing.xxs.value)
            }
        }
        .applySpacing(style?.bounds)
    }
}
