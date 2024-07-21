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
                    fatalError("getLines response broken")
                }
                let lines = self.buildLinesArray(from: data)
                
                completion(lines)
            }
    }
    
    func getStations(forLineID lineID: Int, completion: @escaping ([Station]) -> Void) {
        AF.request(MetroNetRouter.getStations(lineID))
            .validate()
            .responseData { response in
                guard let data = response.value else {
                    fatalError("getStations response broken")
                }
                let stations = self.buildStationsArray(from: data)
                
                completion(stations)
            }
    }
    
    // MARK: - Handlers
    private func buildLinesArray(from data: Data) -> [Line] {
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
    
    private func buildStationsArray(from data: Data) -> [Station] {
        var stations = [Station]()
        // TODO: encoding to array
        return stations
    }
}
