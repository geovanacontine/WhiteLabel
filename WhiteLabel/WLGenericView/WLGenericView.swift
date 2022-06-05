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
    
    init(viewName: String) {
        self.controller = WLGenericViewController(viewName: viewName)
    }
    
    var body: some View {
        Group {
            if controller.isLoading {
                WLLoadingView()
            } else {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(controller.components, id: \.id) { component in
                            component.render()
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        .navigationBarBackButtonHidden(controller.isRootView())
        .onAppear(perform: {
            controller.loadView()
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                TrecoText(controller.navigationBar?.title ?? "")
                    .textStyle(.heading4, color: ProductSetup.navigationTitleColor)
                    .frame(minWidth: 200)
            }
        }
    }
}
