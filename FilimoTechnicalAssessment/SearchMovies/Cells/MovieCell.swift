//
//  MovieCell.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Static Variables
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var movieCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Public variables
    var movieCoverImageURL: String?
    
    var movieName: String? {
        didSet {
            nameLabel.text = movieName
        }
    }
    
    var releaseDate: String? {
        didSet {
            releaseDateLabel.text = releaseDate
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        applyTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func addSubviews() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(movieCoverImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(releaseDateLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieCoverImageView.widthAnchor.constraint(equalToConstant: 60),
            movieCoverImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func applyTheme() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 16
    }
}

