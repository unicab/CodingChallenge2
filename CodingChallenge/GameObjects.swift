//
//  OptimizeObjects.swift
//  CodingChallenge
//
//  Created by remotetiger on 2/27/17.
//  Copyright © 2017 TamNguyen. All rights reserved.
//

import Foundation

public enum MatrixError: Error {
    case invalidMatrix
    case emptyMatrix
}

public struct PathInfo: CustomStringConvertible {
    let a: Int
    let b: Int
    let sum: Int
    
    init(a: Int, b: Int, sum: Int) {
        self.a = a
        self.b = b
        self.sum = sum
    }
    
    public var description: String {
        return "(\(self.a)->\(self.b))=\(self.sum)"
    }
}

public struct SumaryInfo: Equatable, CustomStringConvertible {
    let totalCost: Int
    let pathIndexes: [Int]
    
    init(totalCost: Int, pathIndexes: [Int]) {
        self.totalCost = totalCost
        self.pathIndexes = pathIndexes
    }
    
    public var description: String {
        return "totalCost(\(self.totalCost)). paths(\(self.pathIndexes))"
    }
}

public func ==(lhs: SumaryInfo, rhs: SumaryInfo) -> Bool {
    return lhs.totalCost == rhs.totalCost && lhs.pathIndexes == rhs.pathIndexes
}
