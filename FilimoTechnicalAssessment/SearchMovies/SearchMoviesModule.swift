//
//  SearchMoviesModule.swift
//  FilimoTechnicalAssessment
//
//  Created Mobin Jahantark on 12/28/22.
//

import UIKit

struct SearchMoviesModule {
    func build() -> UIViewController {
        let presenter = SearchMoviesPresenter()
        let view = SearchMoviesView(presenter: presenter)
        view.presenter = presenter
        return view
    }
}
