//
//  PaginationModel.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import Foundation

struct PaginationModel<T: Codable>: Codable {
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}
