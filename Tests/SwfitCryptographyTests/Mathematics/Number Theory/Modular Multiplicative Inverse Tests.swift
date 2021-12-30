//
//  Modular Multiplicative Inverse Tests.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 29/12/21.
//

import XCTest
import SwfitCryptography
import BigInt

class Modular_Multiplicative_Inverse_T: XCTestCase {
    func test_error() throws {
        /// Given
        let b = 6
        let base = 10
        
        let expectedError = NumberTheory.ModuloArithmaticError.inputIsNotCoprimeWithModuloBase
        
        /// When
        XCTAssertThrowsError(try b.multiplicativeInverse(modulo: base), "Error not thrown when input is not coprime with modulo base") { error in
            /// Then
            guard let computedError = error as? NumberTheory.ModuloArithmaticError else {
                XCTFail("Incorrect error thrown")
                return
            }
            XCTAssertEqual(expectedError, computedError)
        }
    }
    
    func test_computeInverse() throws {
        /// Given
        let b = 3
        let base = 20
        let expectedModuloInverse = BigInt(7)
        
        /// When
        let computedModuloInverse = try b.multiplicativeInverse(modulo: base)
        
        /// Then
        XCTAssertEqual(expectedModuloInverse, computedModuloInverse)
        XCTAssertEqual((BigInt(b) * expectedModuloInverse) % BigInt(base), 1)
    }
}
