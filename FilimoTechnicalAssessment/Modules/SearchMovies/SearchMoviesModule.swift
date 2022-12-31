//
//  SearchMoviesModule.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import UIKit

struct SearchMoviesModule {
    func build(apiClient: APIClient) -> UIViewController {
        let presenter = SearchMoviesPresenter(apiClient: apiClient)
        let view = SearchMoviesView(presenter: presenter)
        presenter.view = view
        return view
    }
}
