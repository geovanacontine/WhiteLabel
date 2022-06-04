//
//  WLIconView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 03/06/22.
//

import SwiftUI
import Treco

enum WLIconType: String {
    case small
    case medium
    case large
}

extension WLIconType {
    var size: CGFloat {
        switch self {
        case .small:
            return 16
        case .medium:
            return 24
        case .large:
            return 32
        }
    }
}

struct WLIconDTO: Decodable {
    let name: String?
    let type: String?
    let color: String?
}

struct WLIconView: View {
    
    let dto: WLIconDTO?
    
    private var type: WLIconType {
        .init(rawValue: dto?.type ?? "") ?? .medium
    }
    
    private var color: Color {
        guard let color = dto?.color else {
            return Color.treco(.neutralDarkPure)
        }
        
        return Color.treco(.init(fromRawValue: color))
    }
    
    var body: some View {
        Image(dto?.name ?? "")
            .resizable()
            .scaledToFit()
            .frame(width: type.size, height: type.size)
            .foregroundColor(color)
    }
}
