//
//  WLAnyComponent.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import Foundation

final class WLAnyComponent: Decodable {
    
    let component: WLComponent?

    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let id = try container.decode(WLComponentType.self, forKey: .id)
            self.component = try id.metatype.init(from: decoder)
        } catch {
            self.component = nil
        }
    }
}

extension WLAnyComponent {
    private enum CodingKeys: CodingKey {
        case id
    }
}
