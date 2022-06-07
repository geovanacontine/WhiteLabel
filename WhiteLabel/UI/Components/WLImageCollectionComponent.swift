//
//  WLImageCollectionComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 06/06/22.
//

import SwiftUI
import Treco

struct WLImageCollectionComponent: WLComponent {
    let tag: String?
    let data: WLImageCollectionDTO?
    let style: WLComponentStyle?
    
    func render() -> AnyView {
        WLImageCollectionView(dto: data, style: style).toAny()
    }
}

struct WLImageCollectionDTO: Decodable {
    let items: [WLImageCollectionItem]?
    let height: Double?
    let width: Double?
    let spacing: Double?
}

struct WLImageCollectionItem: Decodable {
    let url: String?
    let onTap: WLNavigationAction?
}

struct WLImageCollectionView: View {
    let dto: WLImageCollectionDTO?
    let style: WLComponentStyle?
    
    private var margin: CGFloat {
        Spacing.init(fromRawValue: style?.bounds?.left ?? "xs").value
    }
    
    private var height: CGFloat {
        dto?.height ?? 150
    }
    
    private var width: CGFloat {
        dto?.width ?? 307
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: Spacing.init(fromRawValue: style?.bounds?.top ?? "").value)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: dto?.spacing ?? Spacing.xxs.value) {
                    Spacer()
                        .frame(width: margin, height: height)
                    ForEach(dto?.items ?? [], id: \.url) { item in
                        WLImageView(url: item.url, width: width, height: height, border: .medium)
                            .applyNavigation(item.onTap)
                    }
                    Spacer()
                        .frame(width: margin, height: height)
                }
            }
            Spacer()
                .frame(height: Spacing.init(fromRawValue: style?.bounds?.bottom ?? "").value)
        }
    }
}
