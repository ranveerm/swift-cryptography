//
//  Extended Euclid's Algorithm Tests
//
//
//  Created by ranveerm on 27/12/21.
//

import XCTest
import SwfitCryptography
import BigInt

class Extended_Euclid_s_Algorithm_Tests: XCTestCase {
    let inputs: [(a: Int, b: Int)] = [
        (973, 301),
        /// Special Cases
        (6, 6),
        (6, 0)
    ]
    
    let expectedOutputs = [
        (7, 13, -42),
        (6, 1, 0),
        (0, 0, 0)
    ]
    
    func test_euclidsAlgorithm() {
        /// Given `inputs`
        
        /// When
        let computedOutputs = inputs.map { NumberTheory.ExtendedEuclidsAlgorithm($0.0, $0.1).evaludate() }
        
        /// Then
        /// Expected output comparison
        zip(expectedOutputs, computedOutputs).forEach {
            XCTAssertEqual(BigInt($0.0), $1.0)
            XCTAssertEqual(BigInt($0.1), $1.1)
            XCTAssertEqual(BigInt($0.2), $1.2)
        }
        
        /// Bézout's Identity verification
        zip(inputs, computedOutputs).forEach { input, computedOutput in
            let a = BigInt(input.a)
            let b = BigInt(input.b)
            
            let gcd = computedOutput.gcd
            let x = computedOutput.x
            let y = computedOutput.y
            
            XCTAssertEqual(gcd, a * x + b * y)
        }
    }
}
