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
    
    // MARK: - Properties
    weak var view: SearchMoviesViewInterface?
    
    @Published var searchedAddress: String = ""
    private let apiClient: APIClient
    private var cancellable: [AnyCancellable] = []
    private var currentPage = 0
    private var apiTotalResults = Int()
    private var movies: [MovieItemModel] = [] {
        didSet {
            view?.movieHasBeenFetched()
        }
    }
    
    // MARK: - Inits
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        subscribeToSearchedAddress()
    }
    
    private func resetPageResultData() {
        currentPage = 0
        apiTotalResults = 0
    }
    
    // MARK: - Subscribe to get searched address changes
    private func subscribeToSearchedAddress() {
        $searchedAddress
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { searchedText in
                self.searchMovie(from: searchedText)
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Search movie API call
    private func searchMovie(from searchedText: String) {
        guard !searchedText.isEmpty else {
            self.movies = []
            return
        }
        
        view?.movieIsFetching()
        
        let urlRequest = ServerRequest.SearchMovie.searchMovies(apiKey: AppConstants.apiKey, searchQuery: searchedText, page: currentPage + 1).urlRequest
        apiClient.executeRequest(urlRequest) { [weak self] result in
            switch result {
            case .success(let success):
                let decodedModel = try? JSONDecoder().decode(PaginationModel<MovieItemModel>.self, from: success.data)
                self?.movies += decodedModel?.results ?? []
                self?.apiTotalResults = decodedModel?.totalResults ?? 0
                self?.currentPage = (decodedModel?.page ?? 0)
                
                if decodedModel?.totalResults == 0 {
                    self?.view?.resultNotFound()
                }
            case .failure(let failure):
                self?.resetPageResultData()
                self?.view?.couldNotFetchMedia(withError: failure)
            }
        }
    }
}

extension SearchMoviesPresenter: SearchMoviesPresenterInterface {
    func searchBarTextDidChange(to text: String) {
        searchedAddress = text
        
        // Clear the movies array, currentPage, and total results if the user clicks on the x button on the search bar.
        // Without this line, If the users clear the text and immediately start typing there will be a bug
        if text.isEmpty {
            movies = []
            resetPageResultData()
        }
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
