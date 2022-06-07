//
//  Extensions.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 30/05/22.
//

import SwiftUI

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty == true || self == nil
    }
}

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

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
