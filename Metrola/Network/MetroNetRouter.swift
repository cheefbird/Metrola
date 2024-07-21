//
//  MetroNetRouter.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/15/24.
//

import Alamofire
import Foundation

enum MetroNetRouter: URLRequestConvertible {
    case getLines
    case getStations(Int)

    var baseURL: URL {
        return URL(string: "https://api.goswift.ly")!
    }

    var method: HTTPMethod { return .get }

    var path: String {
        return "info/lametro-rail/routes"
    }

    var parameters: [String: String] {
        switch self {
        case let .getStations(line):
            return [
                "route": "\(line)",
                "verbose": "true",
            ]
        default:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": Support.key.rawValue,
        ]
        request.headers = headers

        return try URLEncodedFormParameterEncoder().encode(parameters, into: request)
    }
}
