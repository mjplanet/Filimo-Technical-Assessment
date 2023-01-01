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
            guard let self else { return }
            
            switch result {
            case .success(let success):
                do {
                    try self.decodeApiResult(success.data)
                } catch {
                    self.failedResult(.couldNotDecodeErrorModel)
                }
            case .failure(let failure):
                self.failedResult(failure)
            }
        }
    }
    
    private func failedResult(_ error: NetworkingError) {
        resetPageResultData()
        view?.couldNotFetchMedia(withError: error)
    }
    
    private func decodeApiResult(_ data: Data) throws {
        do {
            let decodedModel = try JSONDecoder().decode(PaginationModel<MovieItemModel>.self, from: data)
            successfulDecodedResult(decodedModel: decodedModel)
        } catch {
            throw error
        }
    }
    
    private func successfulDecodedResult(decodedModel: PaginationModel<MovieItemModel>) {
        if decodedModel.totalResults == 0 {
            movies = []
            view?.showEmptyState()
            view?.resultNotFound()
        } else {
            view?.hideEmptyState()
        }
        
        movies.append(contentsOf: decodedModel.results)
        apiTotalResults = decodedModel.totalResults ?? 0
        currentPage = (decodedModel.page ?? 0)
    }
    
    
    private func resetPageResultData() {
        currentPage = 0
        apiTotalResults = 0
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
            view?.showEmptyState()
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
