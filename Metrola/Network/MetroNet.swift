//
//  MetroNet.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/15/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class MetroNet {
    static let shared = MetroNet()
    
    private init() {}
    
    // MARK: - Requests
    func getLines(completion: @escaping ([Line]) -> Void) {
        AF.request(MetroNetRouter.getLines)
            .validate()
            .responseData { response in
                guard let data = response.value else {
                    fatalError()
                }
                let lines = self.processLines(from: data)
                
                completion(lines)
            }
    }
    
    // MARK: - Handlers
    private func processLines(from data: Data) -> [Line] {
        var lines = [Line]()
        
        do {
            let json = try JSON(data: data)
            let rawLines = json["data"]["routes"].arrayValue
            for line in rawLines {
                lines.append(Line(fromJSON: line))
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return lines
    }
}
