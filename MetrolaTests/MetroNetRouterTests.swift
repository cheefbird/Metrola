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

    func testRouterReuest() throws {
        let request = try! MetroNetRouter.getLines.asURLRequest()
        XCTAssertTrue(request.description == "https://api.goswift.ly/info/lametro-rail/routes")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
