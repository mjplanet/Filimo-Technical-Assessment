//
//  UIImageView+Extension.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: URL?,
                   placeHolder: UIImage? = UIImage(named: "placeHolder"),
                   errorImage: UIImage? = UIImage(named: "fileNotFound"),
                   handler: ((Data?) -> Void)? = nil) {
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(.fade(0.3))]) { result in
            switch result {
            case .success(let image):
                handler?(image.data())
            case .failure(_):
                self.image = errorImage
                handler?(nil)
            }
        }
    }
}
