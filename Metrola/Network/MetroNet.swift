//
//  MetroNet.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/15/24.
//

import Alamofire
import Foundation
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
                let stations = self.buildStationsArray(forLineID: lineID, from: data)

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

    private func buildStationsArray(forLineID lineID: Int, from data: Data) -> [Station] {
        var stations = [Station]()

        do {
            let json = try JSON(data: data)
            let rawStations = json["data"]["routes"].arrayValue
                .first!["directions"].arrayValue
                .first!["stops"].arrayValue
            for station in rawStations {
                stations.append(Station(forLine: lineID, fromJSON: station))
            }
        } catch {
            print(error.localizedDescription)
        }
        return stations
    }
}
