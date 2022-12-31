//
//  Networking.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

class Networking: NetworkingInterface {
    
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request(_ request: URLRequest, responseHandler: @escaping (Result<(data: Data, urlResponse: URLResponse), NetworkingError>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            debugPrint("Response for \(request.url) --> ", data?.prettyPrintedJSONString ?? "")
            DispatchQueue.main.async {
                if let error {
                    responseHandler(.failure(.customError(error: error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, let response = response else {
                    return responseHandler(.failure(.responseIsNotValid))
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    return responseHandler(.failure(.invalidStatusCode))
                }
                
                guard let data = data else {
                    return responseHandler(.failure(.emptyResponse))
                }
                
                responseHandler(.success((data, response)))
            }
        }
        dataTask.resume()
    }
}

extension Data {    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
