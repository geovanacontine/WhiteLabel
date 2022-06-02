//
//  WLStatusBarStyle.swift
//  WhiteLabel
//
//  Created by Pedro Contine on 30/05/22.
//

import SwiftUI

enum WLStatusBarStyle: String {
    case light
    case dark
    
    var systemStyle: UIStatusBarStyle {
        switch self {
        case .light:
            return .lightContent
        case .dark:
            return .darkContent
        }
    }
}
