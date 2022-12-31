//
//  ViewFactoryMethods.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import UIKit

// MARK: - UIScrollView
extension UIScrollView {
    static func makeForScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
}


// MARK: - UILabel
extension UILabel {
    static func makeForTitle(textColor: UIColor? = nil, text: String? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        return label
    }
}

// MARK: - UIStackView
extension UIStackView {
    static func makeForStackView(axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        return stackView
    }
}

// MARK: - UIImageView
extension UIImageView {
    static func makeForImageView(image: UIImage? = nil, contentMode: UIView.ContentMode? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        if let contentMode {
            imageView.contentMode = contentMode
        }
        return imageView
    }
}
