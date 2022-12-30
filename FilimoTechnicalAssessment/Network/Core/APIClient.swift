//
//  APIClient.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

protocol APIClient {
    func executeRequest(_ request: URLRequest, responseHandler handler: @escaping (Result<(data: Data, urlResponse: URLResponse), NetworkingError>) -> Void)
}

class DefaultAPIClient: APIClient {
    var networking: NetworkingInterface
    
    init(networking: NetworkingInterface) {
        self.networking = networking
    }
    
    func executeRequest(_ request: URLRequest, responseHandler handler: @escaping (Result<(data: Data, urlResponse: URLResponse), NetworkingError>) -> Void) {
        networking.request(request, responseHandler: handler)
    }
}
