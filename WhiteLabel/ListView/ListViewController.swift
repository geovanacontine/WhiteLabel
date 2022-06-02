//
//  ListViewController.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Combine
import Foundation

final class ListViewController: ObservableObject {
    
    @Published var components: [WLComponent] = []
    @Published var navigationBar: WLNavigationBarDTO?
    
    func loadView() {
        let response = loadLocalFile(named: "get-home")
        components = response?.body ?? []
        navigationBar = response?.header
    }
    
    func hasNavigationBar() -> Bool {
        navigationBar != nil
    }
    
    func navigationBarDTO() -> WLNavigationBarDTO {
        navigationBar ?? .init(title: "", titleColor: "", backgroundColor: "", statusBarStyle: "")
    }
}

// MARK: - Private Methods

extension ListViewController {
    private func loadLocalFile(named fileName: String) -> WLServerResponse? {
       guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
             let data = try? Data(contentsOf: url) else {
            return nil
       }

       return try? JSONDecoder().decode(WLServerResponse.self, from: data)
    }
}
