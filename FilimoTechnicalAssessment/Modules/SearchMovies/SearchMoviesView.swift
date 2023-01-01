//
//  SearchMoviesView.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import UIKit

protocol SearchMoviesViewInterface: AnyObject {
    func movieFetched()
    func couldNotFetchMedia(withError error: Error)
    func present(_ vc: UIViewController)
}

class SearchMoviesView: UIViewController, ToastInterface {
    
    // MARK: - Properties
    var presenter: SearchMoviesPresenterInterface
    private var dataSource: UICollectionViewDiffableDataSource<Section, MovieItemModel>?
    
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
        configureHierarchy()
        configureDataSource()
        setupSearchBar()
    }
    
    // MARK: - Setups
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.register(MovieCell.nib, forCellWithReuseIdentifier: MovieCell.identifier)
        view.addSubview(collectionView)
        
        navigationItem.titleView = movieSearchBar
    }
    
    private func setupSearchBar() {
        movieSearchBar.delegate = self
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
    }
    // MARK: - Actions
    
}

extension SearchMoviesView: SearchMoviesViewInterface {
    func movieFetched() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieItemModel>()
        snapshot.appendSections([.main])
        let movies = presenter.getMovies()
        snapshot.appendItems(movies)
        dataSource?.apply(snapshot)
    }
    
    func couldNotFetchMedia(withError error: Error) {
        if error is NetworkingError {
            showToast(text: error.localizedDescription)
        }
    }
    
    func present(_ vc: UIViewController) {
        self.present(vc, animated: true)
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
