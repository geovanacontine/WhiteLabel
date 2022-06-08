//
//  WLGenericView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI
import Treco

struct WLGenericView: View {
    
    @ObservedObject var controller: WLGenericViewController
    private let productSettings: WLProductSettings
    
    init(viewName: String,
         productSettings: WLProductSettings = WLProductSettings.shared) {
        
        self.controller = WLGenericViewController(viewName: viewName)
        self.productSettings = productSettings
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.treco(.neutralLightPure))
                .frame(height: 1)
                .addShadow(.level1, color: .neutralDark3)
                .isVisible(productSettings.hasNavigationBarShadow)
            Group {
                if controller.isLoading {
                    WLLoadingView()
                } else {
                    ScrollView(scrollAxes, showsIndicators: false) {
                        LazyVStack {
                            ForEach(controller.view?.body ?? [], id: \.tag) { component in
                                component.render()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(controller.isRootView())
        .toolbar {
            ToolbarItem(placement: .principal) {
                TrecoText(controller.view?.header?.title ?? "")
                    .textStyle(.heading4, color: productSettings.navigationTitleColor)
                    .frame(minWidth: 200)
            }
        }
        .task {
            await controller.loadView()
        }
    }
    
    private var scrollAxes: Axis.Set {
        let canScroll = controller.view?.settings?.canScroll ?? true
        return canScroll ? .vertical : []
    }
}
