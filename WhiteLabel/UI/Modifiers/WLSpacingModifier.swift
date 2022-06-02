//
//  WLSpacingModifier.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 28/05/22.
//

import SwiftUI
import Treco

struct WLSpacingModifier: ViewModifier {
    let bounds: WLComponentBounds?
    
    private var top: CGFloat {
        guard let top = bounds?.top else {
            return 0
        }
        
        return Spacing(fromRawValue: top).value
    }
    
    private var bottom: CGFloat {
        guard let bottom = bounds?.bottom else {
            return 0
        }
        
        return Spacing(fromRawValue: bottom).value
    }
    
    private var left: CGFloat {
        guard let left = bounds?.left else {
            return Spacing.xs.value
        }
        
        return Spacing(fromRawValue: left).value
    }
    
    private var right: CGFloat {
        guard let right = bounds?.right else {
            return Spacing.xs.value
        }
        
        return Spacing(fromRawValue: right).value
    }
    
    private var alignment: WLAlignmentStyle {
        .init(rawValue: bounds?.alignment ?? "") ?? .left
    }
    
    func body(content: Content) -> some View {
        VStack {
            Spacer()
                .frame(height: top)
            HStack {
                Spacer()
                    .frame(width: left)
                
                if alignment == .right || alignment == .center {
                    Spacer()
                }
                
                content
                
                if alignment == .left || alignment == .center {
                    Spacer()
                }
                
                Spacer()
                    .frame(width: right)
            }
            Spacer()
                .frame(height: bottom)
        }
    }
}

extension View {
    func applySpacing(_ bounds: WLComponentBounds?) -> some View {
        modifier(WLSpacingModifier(bounds: bounds))
    }
}
