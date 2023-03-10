//
//  MovieDetailView.swift
//  FilimoTechnicalAssessment
//
//  Created Mobin Jahantark on 12/31/22.
//

import UIKit

protocol MovieDetailViewInterface: AnyObject {
    func setMovieImage(from url: URL?)
    func setMovieTitle(_ title: String?)
    func setMovieSummary(_ summary: String?)
}

class MovieDetailView: UIViewController {
    var presenter: MovieDetailPresenterInterface
    
    // MARK: - Inits
    init(presenter: MovieDetailPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var scrollView = UIScrollView.makeForScrollView()
    private lazy var stackView = UIStackView.makeForStackView()
    private lazy var imageView = UIImageView.makeForImageView()
    private lazy var titleLabel = UILabel.makeForTitle()
    private lazy var descriptionLabel = UILabel.makeForTitle()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setTexts()
        applyTheme()
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Set values
    private func setTexts() {
        self.title = .navTitles(.movieDetail)
    }
    
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }

    private func applyTheme() {
        view.backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0
        
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 16
    }
}

extension MovieDetailView: MovieDetailViewInterface {
    func setMovieImage(from url: URL?) {
        imageView.loadImage(url: url)
    }
    
    func setMovieTitle(_ title: String?) {
        titleLabel.text = title
    }
    
    func setMovieSummary(_ summary: String?) {
        descriptionLabel.text = summary
    }
}
