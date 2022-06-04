//
//  GenericView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI

struct GenericView: View {
    
    @ObservedObject var controller: GenericViewController
    
    init(viewName: String) {
        self.controller = GenericViewController(viewName: viewName)
        UIApplication.shared.statusBarStyle = .darkContent
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
        .if(controller.hasNavigationBar()) { view in
            view.setupNavigationBar(dto: controller.navigationBarDTO())
        }
        .onAppear(perform: {
            controller.loadView()
        })
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        GenericView(viewName: "home")
    }
}
