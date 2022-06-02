//
//  Extensions.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 30/05/22.
//

import SwiftUI

extension View {
    func toAny() -> AnyView {
        return AnyView(self)
    }
}

extension View {
  @ViewBuilder
  func `if`<Transform: View>(_ condition: Bool, transform: (Self) ->  Transform) -> some View {
    if condition { transform(self) }
    else { self }
  }
}
