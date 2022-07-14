//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Глеб Коваленко on 14.07.2022.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        
        let enteredString = "sin(cos(5)) + (1 + (_5) + 2.6)*3.9"
        let expectedToken: [Token] = [.function(.sin), .bracket(.open), .function(.cos), .bracket(.open), .number(5.0), .bracket(.close), .bracket(.close), .binaryOp(.addition), .bracket(.open), .number(1.0), .binaryOp(.addition), .bracket(.open), .unaryOp(.negative), .number(5.0), .bracket(.close), .binaryOp(.addition), .number(2.6), .bracket(.close), .binaryOp(.multiply), .number(3.9)]
        
        let tokenArray = try parser(enteredString: enteredString)
        print("\n\n",tokenArray)
        
        XCTAssert(expectedToken == tokenArray)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
