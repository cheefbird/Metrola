//
//  MetroNetRouterTests.swift
//  MetroNetRouterTests
//
//  Created by Francis Breidenbach on 7/15/24.
//

import XCTest
@testable import Metrola

final class MetroNetRouterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
