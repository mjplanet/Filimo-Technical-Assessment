//
//  Texts.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import Foundation

/// All `UIButton` and `UIBarButtonItem` titles
enum ButtonText: String {
    case button = "button_button_button"
    var comment: String {
        switch self {
        default: return "no comment"
        }
    }
}

/// Navigation titles
enum NavTitleText: String {
    case movieDetail = "navTitle_movieDetail"
    var comment: String {
        switch self {
        default: return "no comment"
        }
    }
}

/// Textfield and TextView placeholder
enum PlaceholderText: String {
    case placeHolder = "placeholder_placeHolder_placeholder"
    var comment: String {
        switch self {
        default: return "no comment"
        }
    }
}

enum LabelText: String {
    // MARK: - Home - Labels
    case label = "label_lbl_label"
    var comment: String {
        switch self {
        default: return "no comment"
        }
    }
}
