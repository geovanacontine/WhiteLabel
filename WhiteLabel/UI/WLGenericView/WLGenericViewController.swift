//
//  WLGenericViewController.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Treco
import Combine
import Foundation
import UIKit

final class WLGenericViewController: ObservableObject {
    
    @Published var view: WLServerView?
    @Published var isLoading = false
    
    private let network: WLNetworkProtocol
    private let viewName: String
    
    init(viewName: String, network: WLNetworkProtocol = WLNetwork()) {
        self.viewName = viewName
        self.network = network
    }
    
    @MainActor
    func loadView() async {
        guard view == nil else {
            return
        }
        
        isLoading = true
        view = await network.getView(named: viewName)
        isLoading = false
    }
    
    func isRootView() -> Bool {
        viewName == WLLocalView.home.rawValue
    }
}
