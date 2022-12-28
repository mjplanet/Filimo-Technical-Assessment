//
//  SearchMoviesView.swift
//  FilimoTechnicalAssessment
//
//  Created Mobin Jahantark on 12/28/22.
//

import UIKit

protocol SearchMoviesViewInterface: AnyObject {
}

class SearchMoviesView: UIViewController {
    
    var presenter: SearchMoviesPresenterInterface
    
    init(presenter: SearchMoviesPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Setups
    

    
    // MARK: - Actions
    
}



extension SearchMoviesView: SearchMoviesViewInterface {
}
