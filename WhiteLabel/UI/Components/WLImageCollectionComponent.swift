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
}

struct WLImageCollectionItem: Decodable {
    let url: String?
}

struct WLImageCollectionView: View {
    let dto: WLImageCollectionDTO?
    let style: WLComponentStyle?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(dto?.items ?? [], id: \.url) { item in
                    WLImageView(name: nil, size: .bannerMD, url: item.url, border: .medium)
                }
            }
        }
        .applySpacing(.init(top: style?.bounds?.top,
                            bottom: style?.bounds?.bottom,
                            left: style?.bounds?.left,
                            right: style?.bounds?.right,
                            alignment: "right"))
    }
}
