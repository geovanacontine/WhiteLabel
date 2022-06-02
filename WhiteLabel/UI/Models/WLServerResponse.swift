//
//  WLServerResponse.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Foundation

struct WLServerResponse: Decodable {
    let body: [WLComponent]
    let header: WLNavigationBarDTO?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.body = try container.decode([WLAnyComponent].self, forKey: .body).compactMap { $0.component }
        self.header = try? container.decode(WLNavigationBarDTO.self, forKey: .header)
    }
}

extension WLServerResponse {
    private enum CodingKeys: CodingKey {
        case body
        case header
    }
}
