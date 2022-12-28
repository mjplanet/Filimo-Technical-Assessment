//
//  SearchMoviesPresenter.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/28/22.
//

import Foundation

protocol SearchMoviesPresenterInterface {
    func viewDidLoad()
}

class SearchMoviesPresenter: NSObject {
    weak var view: SearchMoviesViewInterface?
}

extension SearchMoviesPresenter: SearchMoviesPresenterInterface {
    func viewDidLoad() {
    }
}
