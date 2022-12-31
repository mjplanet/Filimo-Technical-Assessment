//
//  SearchMoviesPresenter.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import Foundation

protocol SearchMoviesPresenterInterface {
    func viewDidLoad()
    func searchMovie(from searchedText: String)
    func didSelectItemAt(_ indexPath: IndexPath)
    var movies: [MovieItemModel] { get }
}

class SearchMoviesPresenter: NSObject {
    weak var view: SearchMoviesViewInterface?
    
    private let apiClient: APIClient
    internal var movies: [MovieItemModel] = []
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
     func searchMovie(from searchedText: String) {
        let urlRequest = ServerRequest.SearchMovie.searchMovies(apiKey: AppConstants.apiKey, searchQuery: searchedText, page: 1).urlRequest
        apiClient.executeRequest(urlRequest) { [weak self] result in
            switch result {
            case .success(let success):
                let decodedModel = try? JSONDecoder().decode(PaginationModel<MovieItemModel>.self, from: success.data)
                self?.movies = decodedModel?.results ?? []
                self?.view?.movieFetched()
            case .failure(let failure):
                break
            }
        }
    }
    
}

extension SearchMoviesPresenter: SearchMoviesPresenterInterface {
    func viewDidLoad() {
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
    }
}
