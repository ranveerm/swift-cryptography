//
//  Fast Modular Exponentiation Tests.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 3/1/2022.
//

import XCTest

import SwfitCryptography
import BigInt

class Fast_Modular_Exponentiation_Tests: XCTestCase {
    func test_fastModularExponentiation() {
        /// Given
        let base: BigInt = 98765
        let modBase: BigInt = 123557
        let exponent: BigInt = 1234
        
        let expectedResult: BigInt = 70506
        
        /// When
        let computedResult = base.fastModularExponentiation(pow: exponent, mod: modBase)
        
        /// Then
        XCTAssertEqual(expectedResult, computedResult)
    }
}
