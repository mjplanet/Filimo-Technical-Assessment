//
//  MovieDetailModule.swift
//  FilimoTechnicalAssessment
//
//  Created Mobin Jahantark on 12/31/22.
//

import UIKit

struct MovieDetailModule {
    func build(selectedMovie: MovieItemModel) -> UIViewController {
        let presenter = MovieDetailPresenter(selectedMovie: selectedMovie)
        let view = MovieDetailView(presenter: presenter)
        presenter.view = view
        return view
    }
}
