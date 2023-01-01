//
//  MovieDetailPresenter.swift
//  FilimoTechnicalAssessment
//
//  Created Mobin Jahantark on 12/31/22.
//

import Foundation

protocol MovieDetailPresenterInterface {
    func viewDidLoad()
}

class MovieDetailPresenter {
    weak var view: MovieDetailViewInterface?
    private var selectedMovie: MovieItemModelInterface
    
    init(selectedMovie: MovieItemModelInterface) {
        self.selectedMovie = selectedMovie
    }

}

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func viewDidLoad() {
        view?.setMovieImage(from: selectedMovie.imageURL)
        view?.setMovieTitle(selectedMovie.title)
        view?.setMovieSummary(selectedMovie.summary)
    }
}
