//
//  MovieItemModelInterface.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import Foundation

protocol MovieItemModelInterface {
    var title: String? { get }
    var summary: String? { get }
    var thumbnailURL: URL? { get }
    var imageURL: URL? { get }
    var releaseDate: String? { get }
}
