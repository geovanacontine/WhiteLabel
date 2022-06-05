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
    
    private let viewName: String
    
    init(viewName: String) {
        self.viewName = viewName
    }
    
    func loadView() {
        guard components.isEmpty else {
            return
        }
        
        isLoading = true
        components = []
        navigationBar = nil
        
        requestView() { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func isRootView() -> Bool {
        viewName == "home"
    }
}

// MARK: - Private Methods

extension WLGenericViewController {
    private func loadLocalFile(named fileName: String) -> WLServerResponse? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode(WLServerResponse.self, from: data)
    }
    
    private func handleResponse(_ response: WLServerResponse?) {
        let responseView = response ?? loadLocalFile(named: "error")

        components = responseView?.body ?? []
        navigationBar = responseView?.header
        isLoading = false
    }
    
    private func requestView(completion: @escaping (WLServerResponse?) -> Void) {
        if ProductSetup.shouldDelayRequests {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                completion(self?.loadLocalFile(named: self?.viewName ?? ""))
            }
        } else {
            completion(loadLocalFile(named: viewName))
        }
    }
}
