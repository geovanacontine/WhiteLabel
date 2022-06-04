//
//  GenericViewController.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Combine
import Foundation

final class GenericViewController: ObservableObject {
    
    @Published var components: [WLComponent] = []
    @Published var navigationBar: WLNavigationBarDTO?
    @Published var isLoading = false
    
    private let viewName: String
    
    init(viewName: String) {
        self.viewName = viewName
    }
    
    func loadView() {
        isLoading = true
        components = []
        navigationBar = nil
        
        requestView() { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    func hasNavigationBar() -> Bool {
        navigationBar != nil
    }
    
    func navigationBarDTO() -> WLNavigationBarDTO {
        navigationBar ?? .init(title: "", titleColor: "", backgroundColor: "", statusBarStyle: "")
    }
    
    private func handleResponse(_ response: WLServerResponse?) {
        let responseView = response ?? loadLocalFile(named: "error")

        components = responseView?.body ?? []
        navigationBar = responseView?.header
        isLoading = false
    }
    
    private func requestView(completion: @escaping (WLServerResponse?) -> Void) {
        if ProductSettings.shouldDelayRequests {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                completion(self?.loadLocalFile(named: self?.viewName ?? ""))
            }
        } else {
            completion(loadLocalFile(named: viewName))
        }
    }
}

// MARK: - Private Methods

extension GenericViewController {
    private func loadLocalFile(named fileName: String) -> WLServerResponse? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return try? JSONDecoder().decode(WLServerResponse.self, from: data)
    }
}
