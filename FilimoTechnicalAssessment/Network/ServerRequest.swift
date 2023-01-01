//
//  ServerRequest.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

enum ServerRequest {
    enum SearchMovie {
        static func searchMovies(apiKey: String, searchQuery: String, page: Int) -> HTTPRequest {
            let url: URLPath = .baseURL / .search / .movie
            let parameters = ["api_key": apiKey,
                              "query": searchQuery,
                              "page": "\(page)",
                              "language": Locale.current.language.languageCode?.identifier ?? "en"] as [String : Any]
            
            return .init(url: url, method: .get, parameters: parameters)
        }
    }
}
