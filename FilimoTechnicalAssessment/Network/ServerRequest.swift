//
//  ServerRequest.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

enum ServerRequest {
    enum SearchMovie {
        static func searchMovies(apiKey: String, searchQuery: String, page: Int) -> HTTPRequest<[String]> {
            let url: URLPath = .baseURL / .search / .movie
//        https://api.themoviedb.org/3/search/movie?api_key=852ffe4cfff2346ad60b709d653c5ea3&query=friends&page=2
            return .init(url: url, method: .get)
        }
    }
}
