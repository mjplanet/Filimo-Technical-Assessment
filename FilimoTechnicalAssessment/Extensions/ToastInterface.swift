//
//  ToastInterface.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 1/1/23.
//

import Toast
import UIKit

protocol ToastInterface {
    func showToast(text: String)
}

extension ToastInterface {
    func showToast(text: String) {
        let toast = Toast.text(text)
        toast.show()
    }
}
