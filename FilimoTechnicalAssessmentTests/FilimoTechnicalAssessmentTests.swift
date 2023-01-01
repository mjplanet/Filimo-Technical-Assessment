//
//  FilimoTechnicalAssessmentTests.swift
//  FilimoTechnicalAssessmentTests
//
//  Created by Mobin Jahantark on 1/1/23.
//

import XCTest
@testable import FilimoTechnicalAssessment

final class FilimoTechnicalAssessmentTests: XCTestCase {

    let apiClient: APIClient = DefaultAPIClient(networking: Networking())
    
    func testUrlPath() {
        let testUrl = "https://api.themoviedb.org/3/search/movie"
        let testUrlPath = URLPath.baseURL + .search + .movie

        XCTAssertEqual(testUrl, testUrlPath.rawValue)
    }
    
    func testFetchSearchMovies() {
        let expectation = self.expectation(description: "Calling API")
        
        let urlRequest = ServerRequest.SearchMovie.searchMovies(apiKey: AppConstants.apiKey, searchQuery: "harry potter", page: 1).urlRequest
        
        let decoder = JSONDecoder()
        
        apiClient.executeRequest(urlRequest) { result in
            switch result {
            case .success(let success):
                do {
                    let movieResult = try decoder.decode(PaginationModel<MovieItemModel>.self, from: success.data)
                } catch {
                    XCTFail("Can't decode to pagination model from network response")
                }
            case .failure(let failure):
                XCTFail("Network error (\(failure.localizedDescription))")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60)
    }
}
