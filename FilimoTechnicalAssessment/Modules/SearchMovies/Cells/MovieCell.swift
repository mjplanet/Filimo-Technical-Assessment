//
//  MovieCell.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Static Variables
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet weak private var movieCoverImageView: UIImageView!
    @IBOutlet weak private var movieTitleLabel: UILabel!
    @IBOutlet weak private var movieReleasedDateLabel: UILabel!
    
    // MARK: - Public variables
    var movieName: String? {
        didSet {
            movieTitleLabel.text = movieName
        }
    }
    
    var releaseDate: String? {
        didSet {
            movieReleasedDateLabel.text = releaseDate
        }
    }
    
    var movieCoverImageURL: URL? {
        didSet {
            movieCoverImageView.loadImage(url: movieCoverImageURL)
        }
    }
}
