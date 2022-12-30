//
//  HTTPRequest.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

public typealias HTTPParameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public struct HTTPRequest<Model> {
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
        let cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        var request = URLRequest(url: url, cachePolicy: cachePolicy)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body?.serializedData
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        parameters?.forEach({ key, value in
            if let valueString = value as? String {
                request.addValue(valueString, forHTTPHeaderField: key)
            }
        })
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
