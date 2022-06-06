//
//  WLComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI

protocol WLComponent: Decodable {
    var tag: String? { get }
    func render() -> AnyView
}
