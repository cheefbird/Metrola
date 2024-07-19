//
//  MetroNet.swift
//  Metrola
//
//  Created by Francis Breidenbach on 7/15/24.
//

import Foundation
import Alamofire

class MetroNet {
    static let shared = MetroNet()
    
    private init() {}
    
    // MARK: - Requests
    func getLines() {
        AF.request(MetroNetRouter.getLines)
            .validate()
            .responseData { response in
                guard let data = response.value else {
                    fatalError()
                }

            }
    }
    
}
