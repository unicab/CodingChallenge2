//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by remotetiger on 2/27/17.
//  Copyright © 2017 TamNguyen. All rights reserved.
//

import XCTest

class CodingChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1() {
        let matrix = [[3, 4, 1, 2, 8, 6],
                      [6, 1, 8, 2, 7, 4],
                      [5, 9, 3, 9, 9, 5],
                      [8, 4, 1, 3, 2, 6],
                      [3, 7, 2, 8, 6, 4]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 16, pathIndexes: [1, 2, 3, 4, 4, 5]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }

        } catch {
            XCTFail()
        }
    }
    
    func test2() {
        let matrix = [[3, 4, 1, 2, 8, 6],
                      [6, 1, 8, 2, 7, 4],
                      [5, 9, 3, 9, 9, 5],
                      [8, 4, 1, 3, 2, 6],
                      [3, 7, 2, 1, 2, 3]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 11, pathIndexes: [1, 2, 1, 5, 4, 5]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test3() {
        let matrix = [[19, 10, 19, 10, 19],
                      [21, 23, 20, 19, 12],
                      [20, 12, 20, 11, 10]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 48, pathIndexes: [1, 1, 1]), false)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test4() {
        let matrix = [[5, 8, 5, 3, 5]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 26, pathIndexes: [1, 1, 1, 1, 1]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test5() {
        let matrix = [[5],[8],[5],[3],[5]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 3, pathIndexes: [4]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test6() {
        let matrix = [[5, 4, "H"],
                      [8, "M", 7],
                      [5, 7, 5]]
        
        print("\n")
        
        do {
            let _ = try computeBestPath(forInput: matrix)
            XCTFail("TEST FAILED: should throw invalid matrix")
        } catch {
            XCTAssertTrue((error as? MatrixError) == MatrixError.invalidMatrix, "TEST FAILED: should be true")
        }
    }
    
    func test7() {
        let matrix1: [[Int]] = [[]]
        let matrix2: [[Int]]? = nil
        
        print("\n")
        do {
            let _ = try computeBestPath(forInput: matrix1)
            XCTFail("TEST FAILED: should throw empty matrix")
        } catch {
            print(error)
            XCTAssertTrue((error as? MatrixError) == MatrixError.emptyMatrix, "TEST FAILED: should be true")
        }
        
        print("\n")
        do {
            let _ = try computeBestPath(forInput: matrix2)
            XCTFail("TEST FAILED: should throw invalid matrix")
        } catch {
            print(error)
            XCTAssertTrue((error as? MatrixError) == MatrixError.invalidMatrix, "TEST FAILED: should be true")
        }
    }
    
    func test8() {
        let matrix = [[69, 10, 19, 10, 19],
                      [51, 23, 20, 19, 12],
                      [60, 12, 20, 11, 10]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 0, pathIndexes: []), false)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test9() {
        let matrix = [[60, 3, 3, 6],
                      [6, 3, 7, 9],
                      [5, 6, 8, 3]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 14, pathIndexes: [3, 1, 1, 3]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
    
    func test10() {
        let matrix = [[6, 3, -5, 9],
                      [-5, 2, 4, 10],
                      [3, -2, 6, 10],
                      [6, -1, -2, 10]]
        
        print("\n")
        let expected = (SumaryInfo(totalCost: 0, pathIndexes: [2, 3, 4, 1]), true)
        
        do {
            if let bestPath = try computeBestPath(forInput: matrix) {
                XCTAssertTrue(bestPath.1 == expected.1 && bestPath.0 == expected.0,
                              "TEST FAILED: does not match expected value")
            } else {
                XCTFail()
            }
            
        } catch {
            XCTFail()
        }
    }
}
