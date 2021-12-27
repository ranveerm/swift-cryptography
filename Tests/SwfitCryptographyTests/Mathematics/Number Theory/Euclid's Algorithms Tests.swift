//
//  Euclid's Algorithm Tests
//
//
//  Created by ranveerm on 27/12/21.
//

import XCTest
import SwfitCryptography

class Euclid_s_Algorithms_Tests: XCTestCase {
    let inputs = [
        (0, 0),
        (0, 5),
        (5, 0),
        (973, 301)
    ]
    
    let expectedOutputs = [
        0,
        5,
        5,
        7
    ]
    
    func test_euclidsAlgorithm() {
        /// Given `inputs`
        
        /// When
        let computedOutputs = inputs.map { NumberTheory.euclidsAlgorithm($0.0, $0.1) }
        
        /// Then
        zip(expectedOutputs, computedOutputs).forEach { XCTAssertEqual($0, $1) }
    }
}
