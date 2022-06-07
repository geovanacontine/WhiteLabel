//
//  WLCellComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 29/05/22.
//

import SwiftUI
import Treco

struct WLCellComponent: WLComponent {
    let tag: String?
    let data: WLCellDTO?
    let style: WLComponentStyle?
    let actions: WLCellActions?
    
    func render() -> AnyView {
        WLCellView(dto: data, style: style, actions: actions).toAny()
    }
}

struct WLCellActions: Decodable {
    let onTap: WLNavigationAction?
}

struct WLCellDTO: Decodable {
    let title: String?
    let subtitle: String?
    let value: String?
    let icon: WLImageDTO?
    let hasSeparator: Bool?
    let hasDisclosure: Bool?
}

struct WLCellView: View {
    let dto: WLCellDTO?
    let style: WLComponentStyle?
    let actions: WLCellActions?
    
    @State private var isShowingDetailView = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                    .frame(height: Spacing.xs.value)
                HStack {
                    HStack {
                        WLImageView(dto: dto?.icon)
                        Spacer()
                            .frame(width: Spacing.xs.value)
                    }
                    .isVisible(dto?.icon != nil)
                    VStack(alignment: .leading) {
                        TrecoText(dto?.title ?? "")
                            .textStyle(.paragraph)
                        TrecoText(dto?.subtitle ?? "")
                            .textStyle(.description)
                            .isVisible(dto?.subtitle.isNilOrEmpty == false)
                    }
                    Spacer()
                    TrecoText(dto?.value ?? "")
                        .textStyle(.description)
                    HStack {
                        Spacer()
                            .frame(width: Spacing.xs.value)
                        WLImageView(name: "chevron",
                                    size: .iconSM,
                                    tintColor: .neutralDark2)
                    }
                    .isVisible(dto?.hasDisclosure ?? true)
                }
                Spacer()
                    .frame(height: Spacing.xs.value)
            }
            .applyNavigation(actions?.onTap)
            
            Rectangle()
                .fill(Color.treco(.neutralLight2))
                .frame(height: 1)
                .isVisible(dto?.hasSeparator ?? true)
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
                                          size: nil,
                                          url: nil,
                                          width: nil,
                                          height: nil,
                                          border: nil,
                                          tintColor: nil,
                                          isDynamicWidth: false),
                              hasSeparator: true,
                              hasDisclosure: true),
                   style: nil,
                   actions: nil)
    }
}
