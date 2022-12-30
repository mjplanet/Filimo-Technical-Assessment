//
//  URLPath.swift
//  FilimoTechnicalAssessment
//
//  Created by Mobin Jahantark on 12/29/22.
//

import Foundation

public struct URLPath: RawRepresentable {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    static func + (lhs: URLPath, rhs: URLPath) -> URLPath {
        return URLPath(rawValue: lhs.rawValue + "/" + rhs.rawValue)
    }

    public static func / (lhs: URLPath, rhs: URLPath) -> URLPath {
        return lhs + rhs
    }

    public static func / (lhs: URLPath, rhs: String) -> URLPath {
        return lhs + URLPath(rawValue: rhs)
    }

    public var url: URL? {
        return URL(string: rawValue)
    }
}
