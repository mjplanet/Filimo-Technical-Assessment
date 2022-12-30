//
//  NetworkingInterface.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

protocol NetworkingInterface {
    func request(_ request: URLRequest, responseHandler handler: @escaping (Result<(data: Data, urlResponse: URLResponse), NetworkingError>) -> Void)
}
