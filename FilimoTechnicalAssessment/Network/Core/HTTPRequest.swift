//
//  HTTPRequest.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

public typealias HTTPParameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public struct HTTPRequest {
    private(set) var httpMethod: HTTPMethod
    private(set) var parameters: HTTPParameters?
    private(set) var body: Codable?
    private(set) var url: URL
    private(set) var headers: HTTPHeaders?

    public init(url: URL, method: HTTPMethod, parameters: HTTPParameters? = nil, body: Codable? = nil, headers: [String: String]? = nil) {
        self.url = url
        self.httpMethod = method
        self.parameters = parameters
        self.body = body
    }

    public init(url: URLPath, method: HTTPMethod, parameters: HTTPParameters? = nil, body: Codable? = nil, headers: [String: String]? = nil) {
        self.init(url: url.url!, method: method, parameters: parameters, body: body, headers: headers)
    }

    public var urlRequest: URLRequest {
        var components = URLComponents(string: url.absoluteString)
        let cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
 
        var queryItems: [URLQueryItem] = []
        parameters?.forEach({ key, value in
            if let valueString = value as? String {
                let query = URLQueryItem(name: key, value: valueString)
                queryItems.append(query)
            }
        })
        
        components?.queryItems = queryItems
        
        var request = URLRequest(url: components!.url!, cachePolicy: cachePolicy)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body?.serializedData
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
}

extension Encodable {
    var serializedData: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
