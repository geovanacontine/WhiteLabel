//
//  WLLoadingView.swift
//  Production
//
//  Created by Pedro Contine on 04/06/22.
//

import SwiftUI
import Treco

struct WLLoadingView: View {
    var body: some View {
        Spacer()
        ProgressView()
            .tint(.treco(.brandPure))
        Spacer()
    }
}
