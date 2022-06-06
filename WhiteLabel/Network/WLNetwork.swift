//
//  WLNetwork.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 05/06/22.
//

import Foundation

protocol WLNetworkProtocol {
    func getView(named viewName: String,
                 completion: @escaping (WLServerView) -> Void)
}

final class WLNetwork: WLNetworkProtocol {
    
    private let productSettings: WLProductSettings
    
    init(productSettings: WLProductSettings = WLProductSettings.shared) {
        self.productSettings = productSettings
    }
    
    func getView(named viewName: String,
                 completion: @escaping (WLServerView) -> Void) {
        
        switch productSettings.environment {
        case .local:
            getLocalViewWithDelay(named: viewName, completion: completion)
        case .production:
            getRemoteView(named: viewName, completion: completion)
        }
    }
}

extension WLNetwork {
    private func getRemoteView(named viewName: String,
                               completion: @escaping (WLServerView) -> Void) {
        
        let view = getLocalView(named: viewName)
        let errorView = getLocalErrorView()
        let responseView = view ?? errorView
        completion(responseView)
    }
    
    private func getLocalViewWithDelay(named viewName: String,
                                       completion: @escaping (WLServerView) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            let localView = self?.getLocalView(named: viewName)
            let errorView = self?.getLocalErrorView()
            let responseView = localView ?? errorView
            completion(responseView ?? .init(body: [], header: nil))
        }
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
