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
    let subtitle: String?
    let value: String?
    let icon: WLIconDTO?
    let hasSeparator: Bool?
    let hasDisclosure: Bool?
}

struct WLCellView: View {
    let dto: WLCellDTO?
    let style: WLComponentStyle?
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    WLIconView(dto: dto?.icon)
                    Spacer()
                        .frame(width: 12)
                }
                .visible(dto?.icon != nil)
                VStack(alignment: .leading) {
                    TrecoText(dto?.title ?? "")
                        .textStyle(.paragraph)
                    TrecoText(dto?.subtitle ?? "")
                        .textStyle(.description)
                        .visible(dto?.subtitle.isNilOrEmpty == false)
                }
                Spacer()
                TrecoText(dto?.value ?? "")
                    .textStyle(.description)
                if dto?.hasDisclosure ?? true {
                    Spacer()
                        .frame(width: 12)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.treco(.neutralDark3))
                }
            }
            if dto?.hasSeparator ?? true {
                Rectangle()
                    .fill(.quaternary)
                    .frame(height: 1)
                Spacer()
                    .frame(height: Spacing.xs.value)
            }
        }
        .applySpacing(style?.bounds)
    }
}

struct WLCellView_Previews: PreviewProvider {
    static var previews: some View {
        WLCellView(dto: .init(title: "Title",
                              subtitle: "Subtitle",
                              value: "Value",
                              icon: .init(name: "bell",
                                          type: nil,
                                          color: nil),
                              hasSeparator: true,
                              hasDisclosure: true),
                   style: nil)
    }
}
