//
//  ListView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var controller: ListViewController
    
    init(jsonName: String) {
        self.controller = ListViewController(jsonName: jsonName)
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(controller.components, id: \.id) { component in
                    component.render()
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
        ListView(jsonName: "home")
    }
}
