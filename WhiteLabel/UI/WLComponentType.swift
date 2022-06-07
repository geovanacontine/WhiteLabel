//
//  WLComponentType.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Foundation

enum WLComponentType: String, Decodable {
    case cell = "CellComponent"
    case text = "TextComponent"
    case verticalSpacing = "VerticalSpacingComponent"
    case imageCollection = "ImageCollectionComponent"
    case image = "ImageComponent"
}

extension WLComponentType {
    var metatype: WLComponent.Type {
        switch self {
        case .cell:
            return WLCellComponent.self
        case .text:
            return WLTextComponent.self
        case .verticalSpacing:
            return WLVerticalSpacingComponent.self
        case .imageCollection:
            return WLImageCollectionComponent.self
        case .image:
            return WLImageComponent.self
        }
    }
}
