//
//  Endpoints.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

extension URLPath {
    static var baseURL: URLPath {
        return .init(rawValue: "https://api.themoviedb.org/3")
    }
    static let search: URLPath = .init(rawValue: "search")
    static let movie: URLPath = .init(rawValue: "movie")
}
