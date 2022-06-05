//
//  WLGenericView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI

struct WLGenericView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
        .navigationTitle(controller.navigationBar?.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if controller.isRootView() {
                    EmptyView()
                } else {
                    Button {
                        didTapBackButton()
                    } label: {
                        Image(systemName: "chevron.left")
//                            .foregroundColor(Color.init(tintColor))
//                            .padding(Spacing.xxs.value)
                    }
                }
            }
        }
        .onAppear(perform: {
            controller.loadView()
        })
    }
    
    private func didTapBackButton() {
        mode.wrappedValue.dismiss()
    }
}
