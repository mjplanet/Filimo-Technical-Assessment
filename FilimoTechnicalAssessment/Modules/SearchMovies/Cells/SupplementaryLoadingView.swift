//
//  SupplementaryLoadingView.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 1/1/23.
//

import UIKit

class SupplementaryLoadingView: UICollectionReusableView {
    
    private lazy var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("code init not configured")
    }
    
    func hideLoading(_ isHidden: Bool) {
        loadingIndicator.isHidden = isHidden
    }
    
    private func configure() {
        self.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        loadingIndicator.startAnimating()
    }
}
