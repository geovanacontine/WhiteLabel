//
//  WLIconView.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 03/06/22.
//

import SwiftUI
import Treco

enum WLImageSize: String {
    case iconSM = "icon_sm"
    case iconMD = "icon_md"
    case iconLG = "icon_lg"
    case iconXL = "icon_xl"
}

extension WLImageSize {
    var width: CGFloat {
        switch self {
        case .iconSM:
            return 16
        case .iconMD:
            return 24
        case .iconLG:
            return 32
        case .iconXL:
            return 48
        }
    }
    
    var height: CGFloat {
        switch self {
        case .iconSM:
            return 16
        case .iconMD:
            return 24
        case .iconLG:
            return 32
        case .iconXL:
            return 48
        }
    }
}

struct WLImageDTO: Decodable {
    let name: String?
    let size: String?
    let url: String?
    let width: Double?
    let height: Double?
    let border: String?
    let tintColor: String?
}

struct WLImageView: View {
    
    let dto: WLImageDTO?
    
    init(dto: WLImageDTO?) {
        self.dto = dto
    }
    
    init(name: String?,
         size: WLImageSize?,
         url: String? = nil,
         width: Double? = nil,
         height: Double? = nil,
         border: BorderRadius? = nil,
         tintColor: Colors? = nil) {
        
        self.dto = .init(name: name,
                         size: size?.rawValue,
                         url: url,
                         width: width,
                         height: height,
                         border: border?.rawValue,
                         tintColor: tintColor?.rawValue)
    }
    
    private var url: URL? {
        URL(string: dto?.url ?? "")
    }
    
    var body: some View {
        if dto?.url != nil {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                Color.treco(.neutralDark3)
            }
            .applyImageStyle(dto)
        } else {
            Image(dto?.name ?? "")
                .resizable()
                .applyImageStyle(dto)
        }
    }
}

struct WLImageModifier: ViewModifier {
    
    let dto: WLImageDTO?
    
    private var isCircle: Bool {
        dto?.border == nil
    }
    
    private var border: BorderRadius {
        .init(rawValue: dto?.border ?? "") ?? .medium
    }
    
    private var color: Color {
        guard let color = dto?.tintColor else {
            return Color.treco(.neutralDarkPure)
        }
        
        return Color.treco(.init(fromRawValue: color))
    }
    
    private var size: WLImageSize {
        .init(rawValue: dto?.size ?? "") ?? .iconMD
    }
    
    private var width: CGFloat {
        dto?.width ?? size.width
    }
    
    private var height: CGFloat {
        dto?.height ?? size.height
    }
    
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: width, height: height)
            .foregroundColor(color)
            .cornerRadius(border.value)
            .if(isCircle) { view in
                view.clipShape(Circle())
            }
    }

}

extension View {
    func applyImageStyle(_ dto: WLImageDTO?) -> some View {
        modifier(WLImageModifier(dto: dto))
    }
}
