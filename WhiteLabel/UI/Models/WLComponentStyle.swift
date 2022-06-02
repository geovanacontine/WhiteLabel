//
//  WLComponentStyle.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Foundation

struct WLComponentStyle: Decodable {
    let bounds: WLComponentBounds?
}

struct WLComponentBounds: Decodable {
    let top: String?
    let bottom: String?
    let left: String?
    let right: String?
    let alignment: String?
}
