//
//  WLNavigationAction.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 04/06/22.
//

import SwiftUI

struct WLNavigationAction: Decodable {
    let view: String
    
    func destination() -> AnyView {
        ListView(jsonName: view).toAny()
    }
}
