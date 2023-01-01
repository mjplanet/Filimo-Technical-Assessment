//
//  MovieItemModel.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/31/22.
//

import Foundation

struct MovieItemModel: Codable, Hashable, MovieItemModelInterface {
    var identifier = UUID()
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool
    let averageVote: Double?
    let voteCount: Int?
        
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case averageVote = "vote_average"
        case voteCount = "vote_count"
    }
    
    // MARK: - Computed values
    var summary: String? {
        return overview
    }
    
    var thumbnailURL: URL? {
        guard let posterPath else { return nil }
        let baseUrlPath = "https://image.tmdb.org/t/p/w200"
        return URL(string: baseUrlPath + posterPath)
    }
    
    var imageURL: URL? {
        guard let posterPath else { return nil }
        let baseUrlPath = "https://image.tmdb.org/t/p/original"
        return URL(string: baseUrlPath + posterPath)
    }
}
