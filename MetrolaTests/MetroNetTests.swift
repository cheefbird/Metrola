//
//  MetroNetTests.swift
//  MetrolaTests
//
//  Created by Francis Breidenbach on 7/15/24.
//

@testable import Metrola
import XCTest

final class MetroNetTests: XCTestCase {
    let instance = MetroNet.shared

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetLinesDataResponse() throws {
        instance.getLines()
    }

}
