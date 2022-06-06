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
    
    @Published var components: [WLComponent] = []
    @Published var navigationBar: WLNavigationBar?
    @Published var isLoading = false
    
    private let network: WLNetworkProtocol
    private let viewName: String
    
    init(viewName: String, network: WLNetworkProtocol = WLNetwork()) {
        self.viewName = viewName
        self.network = network
    }
    
    func loadView() {
        guard components.isEmpty else {
            return
        }
        
        isLoading = true
        
        network.getView(named: viewName) { [weak self] view in
            self?.components = view.body
            self?.navigationBar = view.header
            self?.isLoading = false
        }
    }
    
    func isRootView() -> Bool {
        viewName == WLLocalView.home.rawValue
    }
}
