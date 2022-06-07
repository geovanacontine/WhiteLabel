//
//  WLNetwork.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 05/06/22.
//

import Foundation

protocol WLNetworkProtocol {
    func getView(named viewName: String) async -> WLServerView
}

final class WLNetwork: WLNetworkProtocol {
    
    private let productSettings: WLProductSettings
    
    init(productSettings: WLProductSettings = WLProductSettings.shared) {
        self.productSettings = productSettings
    }
    
    func getView(named viewName: String) async -> WLServerView {
        switch productSettings.environment {
        case .local:
            return await getLocalViewWithDelay(named: viewName)
        case .production:
            return await getRemoteView(named: viewName)
        }
    }
}

extension WLNetwork {
    private func getRemoteView(named viewName: String) async -> WLServerView {
        let view = getLocalView(named: viewName)
        let errorView = getLocalErrorView()
        return view ?? errorView
    }
    
    private func getLocalViewWithDelay(named viewName: String) async -> WLServerView {
        try? await Task.sleep(seconds: 1)
        let localView = getLocalView(named: viewName)
        let errorView = getLocalErrorView()
        return localView ?? errorView
    }
    
    private func getLocalView(named viewName: String) -> WLServerView? {
        guard let url = Bundle.main.url(forResource: viewName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode(WLServerView.self, from: data)
    }
    
    func getLocalErrorView() -> WLServerView {
        getLocalView(named: WLLocalView.genericError.rawValue) ?? .init(body: [], header: nil)
    }
}
