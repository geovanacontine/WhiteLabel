//
//  WLServerResponse.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Foundation

struct WLServerView: Decodable {
    let settings: WLViewSettings?
    let body: [WLComponent]
    let header: WLNavigationBar?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.settings = try? container.decode(WLViewSettings.self, forKey: .settings)
        self.body = try container.decode([WLAnyComponent].self, forKey: .body).compactMap { $0.component }
        self.header = try? container.decode(WLNavigationBar.self, forKey: .header)
    }
    
    init(body: [WLComponent], header: WLNavigationBar?, settings: WLViewSettings? = nil) {
        self.body = body
        self.header = header
        self.settings = settings
    }
}

extension WLServerView {
    private enum CodingKeys: CodingKey {
        case settings
        case body
        case header
    }
}
