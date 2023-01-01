//
//  SearchMoviesPresenter.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import Combine
import UIKit

protocol SearchMoviesPresenterInterface {
    func searchBarTextDidChange(to text: String)
    func didSelectItemAt(_ indexPath: IndexPath)
    func didReachEndOfList()
    func getMovies() -> [MovieItemModel]
}

class SearchMoviesPresenter {
    weak var view: SearchMoviesViewInterface?
    
    private let apiClient: APIClient
    private var cancellable: [AnyCancellable] = []
    private var currentPage = 1
    private var apiTotalResults = Int()
    private var movies: [MovieItemModel] = [] {
        didSet {
            view?.movieFetched()
        }
    }
    
    @Published var searchedAddress: String = ""
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        subscribeToSearchedAddress()
    }
    
    private func subscribeToSearchedAddress() {
        $searchedAddress
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { searchedText in
                self.searchMovie(from: searchedText)
            }
            .store(in: &cancellable)
    }
    
    private func searchMovie(from searchedText: String) {
        guard !searchedText.isEmpty else {
            self.movies = []
            return
        }
        let urlRequest = ServerRequest.SearchMovie.searchMovies(apiKey: AppConstants.apiKey, searchQuery: searchedText, page: currentPage).urlRequest
        apiClient.executeRequest(urlRequest) { [weak self] result in
            switch result {
            case .success(let success):
                let decodedModel = try? JSONDecoder().decode(PaginationModel<MovieItemModel>.self, from: success.data)
                self?.movies += decodedModel?.results ?? []
                self?.apiTotalResults = decodedModel?.totalResults ?? 0
                self?.currentPage = (decodedModel?.page ?? 0) + 1
            case .failure(let failure):
                self?.view?.couldNotFetchMedia(withError: failure)
            }
        }
    }
}

extension SearchMoviesPresenter: SearchMoviesPresenterInterface {
    func searchBarTextDidChange(to text: String) {
        searchedAddress = text
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let movieDetailModule = MovieDetailModule().build(selectedMovie: selectedMovie)
        let navigationController = UINavigationController(rootViewController: movieDetailModule)
        view?.present(navigationController)
    }
    
    func getMovies() -> [MovieItemModel] {
        return movies
    }
    
    func didReachEndOfList() {
        if apiTotalResults > movies.count {
            searchMovie(from: searchedAddress)
        }
    }
}
