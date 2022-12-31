//
//  String+Localize.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import Foundation

extension String {
    static func buttons(_ button: ButtonText, _ variables: [CVarArg] = []) -> String {
        produceString(key: button.rawValue, comment: button.comment, variables: variables)
    }

    static func navTitles(_ title: NavTitleText, _ variables: [CVarArg] = []) -> String {
        produceString(key: title.rawValue, comment: title.comment, variables: variables)
    }
    
    static func placeholders(_ title: PlaceholderText, _ variables: [CVarArg] = []) -> String {
        produceString(key: title.rawValue, comment: title.comment, variables: variables)
    }

    static func labels(_ title: LabelText, _ variables: [CVarArg] = []) -> String {
        produceString(key: title.rawValue, comment: title.comment, variables: variables)
    }
}

fileprivate func produceString(key: String, comment: String, variables: [CVarArg]) -> String {
    let baseString = NSLocalizedString(key, comment: comment)
    return String(format: baseString, arguments: variables)
}
