//
//  MetroNetRouterTests.swift
//  MetroNetRouterTests
//
//  Created by Francis Breidenbach on 7/15/24.
//

@testable import Metrola
import XCTest

final class MetroNetRouterTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testGetLinesReturnsCorrectURL() throws {
        let request = try! MetroNetRouter.getLines.asURLRequest()
        XCTAssertTrue(request.description == "https://api.goswift.ly/info/lametro-rail/routes")
    }
    
    func testGetStationsReturnsCorrectURL() throws {
        let request = try MetroNetRouter.getStations(801).asURLRequest()
        XCTAssertEqual(
            request.description,
            "https://api.goswift.ly/info/lametro-rail/routes?route=801&verbose=true"
        )
    }

}
