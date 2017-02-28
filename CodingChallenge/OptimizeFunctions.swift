//
//  OptimizeFunctions.swift
//  CodingChallenge
//
//  Created by remotetiger on 2/27/17.
//  Copyright © 2017 TamNguyen. All rights reserved.
//

import Foundation

// compute best path for a matrix

public func computeBestPath(forInput input: [[Any]]?) throws -> (SumaryInfo, Bool)? {
    guard let input = input else { throw MatrixError.invalidMatrix }
    guard input.count > 0, let first = input.first, first.count > 0 else { throw MatrixError.emptyMatrix }

    var intMatrix: [[Int]] = []
    var err: MatrixError? = nil
    
    input.forEach {
        do {
            if let intArr = $0 as? [Int] {
                intMatrix.append(intArr)
            } else {
                err = MatrixError.invalidMatrix
            }
        }
    }
    
    if let error = err { throw error }
    
    print("Original Matrix:")
    intMatrix.forEach { print("\($0)") }
    
    // optimize paths
    let optimizedPaths = optimizedPathInfos(input: intMatrix)
    print("\nOptimized Paths:")
    optimizedPaths.forEach { print("\($0)") }
    
    // best path
    if let bestPath = computeBestPath(forPathInfos: optimizedPaths) {
        print("\nfinished(\(bestPath.pathIndexes.count == input.first?.count)) \(bestPath) \n")
        return (bestPath, bestPath.pathIndexes.count == input.first?.count)
    } else {
        return (SumaryInfo(totalCost: 0, pathIndexes: []), false)
    }
}

// given an array of paths. compute the best path and return it's costInfo

fileprivate func computeBestPath(forPathInfos pathInfos: [[PathInfo]]) -> SumaryInfo? {
    // get ordered index by column for a pathInfo array
    
    func getPathOrder(forPath path: [PathInfo]) -> [Int] {
        var pathIndexes: [Int] = []
        
        for (index, item) in path.enumerated() {
            if index == path.count - 1 {
                let comps = (item.a >= 0) ? [item.a + 1] + [item.b + 1] : [item.b + 1]
                pathIndexes.append(contentsOf: comps)
            } else {
                pathIndexes.append(item.a + 1)
            }
        }
        
        return pathIndexes
    }
    
    // computing
    
    guard pathInfos.count > 0 else { return nil }
    var bestCost: SumaryInfo?
    
    pathInfos.forEach {
        let lastSum = $0.last!.sum
        let pathOrder = getPathOrder(forPath: $0)
        let curCost = SumaryInfo(totalCost: lastSum, pathIndexes: pathOrder)
        
        if let sBestCost = bestCost, curCost.totalCost < sBestCost.totalCost {
            bestCost = curCost
        } else if bestCost == nil {
            bestCost = curCost
        }
    }
    
    return bestCost
}


// get all posibbile optimized paths

fileprivate func optimizedPathInfos(input: [[Int]], limit: Int = 50) -> [[PathInfo]] {
    // transpose matrix. processing required column inspections
    let transponsedMatrix = transpose(input: input)
    
    // trackers
    var sums = [Int](repeatElement(0, count: input.count))
    var optimizedPaths: [[PathInfo]] = []
    
    // compute optimized paths
    // final output is an array of arrays, and it changes for each successive column
    
    for (index, column) in transponsedMatrix.enumerated() {
        guard let paths = successivePathInfos(columnSum: sums, column: column, isFirst: index == 0) else { break }
        sums = paths.map { $0.sum }

        if index == 0 || index == 1 { optimizedPaths = transpose(input: [paths]) }
        else if index > 1 {
            var concat: [PathInfo] = []
            var newOptimized: [[PathInfo]] = []
            
            for (_, item) in paths.enumerated() {
                concat = optimizedPaths[item.a] + [item]
                newOptimized.append(concat)
            }
            
            // update optimizedPaths
            optimizedPaths = newOptimized
            
            // stop processing of there is no optimizedPaths
            if (optimizedPaths.count > 0) == false { return [] }
        }
        
        // print("\nColumn \(index):")
        // paths.forEach { print($0) }
        
        // print("\nOptimized Paths:")
        // optimizedPaths.forEach { print($0) }
    }
    
    return optimizedPaths
}


// given the current sums of a column and the successive column
// compute the optimized paths by their index pairs
// order stays the same (indexes of the elements in a column is in order)

fileprivate func successivePathInfos(columnSum: [Int], column: [Int], isFirst: Bool) -> [PathInfo]? {
    guard columnSum.count == column.count else { return nil }
    var infos: [PathInfo] = []
    var exceedTracker = column.count
    
    for (index, ref) in column.enumerated() {
        let indexDec  = index - 1
        let indexInc  = index + 1
        let indexUp   = (indexDec < 0) ? column.count - 1 : indexDec
        let indexDown = (indexInc > column.count - 1) ? 0 : indexInc
        
        let pathInfo1 = PathInfo(a: isFirst ? -1 : indexUp, b: index, sum: ref + columnSum[indexUp])
        let pathInfo2 = PathInfo(a: isFirst ? -1 : index, b: index, sum: ref + columnSum[index])
        let pathInfo3 = PathInfo(a: isFirst ? -1 : indexDown, b: index , sum: ref + columnSum[indexDown])
        
        if let minPath = [pathInfo1, pathInfo2, pathInfo3].min(by: { (pathA, pathB) -> Bool in
            pathA.sum < pathB.sum
        }) {
            infos.append(minPath)
            if minPath.sum > 50 { exceedTracker -= 1 }
        } else {
            break
        }
    }
    
    return exceedTracker > 0 ? infos : nil
}


// transpose a matrix:
// simply converted a matrix [nxm] to [mxn]

fileprivate func transpose<T>(input: [[T]]) -> [[T]] {
    if input.isEmpty { return [[T]]() }
    let count = input[0].count
    var out = [[T]](repeating: [T](), count: count)
    for outer in input {
        for (index, inner) in outer.enumerated() {
            out[index].append(inner)
        }
    }
    
    return out
}
