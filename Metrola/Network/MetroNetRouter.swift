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
    
    var baseURL: URL {
        return URL(string: "https://api.goswift.ly")!
    }
    
    var method: HTTPMethod { return .get }
    
    var path: String {
        return "info/lametro-rail/routes"
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        return request
    }
}
