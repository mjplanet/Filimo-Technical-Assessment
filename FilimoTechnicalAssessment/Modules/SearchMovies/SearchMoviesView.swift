//
//  SearchMoviesView.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import UIKit
import Combine

protocol SearchMoviesViewInterface: AnyObject {
    func movieIsFetching()
    func movieHasBeenFetched()
    func resultNotFound()
    func couldNotFetchMedia(withError error: Error)
    func present(_ vc: UIViewController)
    func showEmptyState()
    func hideEmptyState()
}

class SearchMoviesView: UIViewController, ToastInterface {
    
    // MARK: - Properties
    var presenter: SearchMoviesPresenterInterface
    private var dataSource: UICollectionViewDiffableDataSource<Section, MovieItemModel>?
    @Published private var isLoading = false
    private var cancellable: [AnyCancellable] = []

    private enum Section {
        case main
    }
    
    private lazy var movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Inits
    init(presenter: SearchMoviesPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupNavigationItems()
        configureDataSource()
        setupSearchBar()
        setupEmptyStateView()
    }
    
    // MARK: - Setups
    private func setupNavigationItems() {
        navigationItem.titleView = movieSearchBar
    }
    
    private func setupSearchBar() {
        movieSearchBar.delegate = self
        movieSearchBar.placeholder = "Search movie"
    }
    
    private func setupEmptyStateView() {
        emptyStateImageView.image = UIImage(named: "Movie")
        self.view.addSubview(emptyStateImageView)
        NSLayoutConstraint.activate([
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 200),
            emptyStateImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Setup collection view
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.keyboardDismissMode = .interactive
        collectionView.delegate = self
        collectionView.register(MovieCell.nib, forCellWithReuseIdentifier: MovieCell.identifier)
        view.addSubview(collectionView)
    }

    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createCollectionSection()
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 16
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: configuration)
    }
    
    private func createCollectionSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(92))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(92))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        // Footer
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: "section-footer-element-kind",
            alignment: .bottom)
        
        section.boundarySupplementaryItems = [sectionFooter]
        
        return section
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movieItem -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            cell?.movieName = movieItem.title
            cell?.releaseDate = movieItem.releaseDate
            cell?.movieCoverImageURL = movieItem.thumbnailURL
            return cell
        })
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <SupplementaryLoadingView>(elementKind: "section-footer-element-kind") { _, _, _ in }
        
        dataSource?.supplementaryViewProvider = { _, kind, indexPath in
            let footer = self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
            
            // Subscribe to isLoading and get value in sink closure to show, hide loading
            self.$isLoading.sink { isLoading in
                if isLoading == true {
                    footer.hideLoading(false)
                } else {
                    footer.hideLoading(true)
                }
            }.store(in: &self.cancellable)

            return footer
        }

    }
}

extension SearchMoviesView: SearchMoviesViewInterface {
    func movieIsFetching() {
        isLoading = true
    }
    
    func movieHasBeenFetched() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieItemModel>()
        snapshot.appendSections([.main])
        let movies = presenter.getMovies()
        snapshot.appendItems(movies)
        dataSource?.apply(snapshot)
        
        isLoading = false
    }
    
    func resultNotFound() {
        showToast(text: "Result not found")
    }
    
    func couldNotFetchMedia(withError error: Error) {
        isLoading = false
        if error is NetworkingError {
            showToast(text: error.localizedDescription)
        }
    }
    
    func present(_ vc: UIViewController) {
        self.present(vc, animated: true)
    }
    
    func showEmptyState() {
        emptyStateImageView.isHidden = false
    }
    
    func hideEmptyState() {
        emptyStateImageView.isHidden = true
    }
}

extension SearchMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.bounds.height + scrollView.contentOffset.y >= scrollView.contentSize.height {
            presenter.didReachEndOfList()
        }
    }
}

extension SearchMoviesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextDidChange(to: searchText)
    }
}
