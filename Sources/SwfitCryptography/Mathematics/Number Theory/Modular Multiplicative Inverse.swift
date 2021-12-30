//
//  Modular Multiplicative Inverse.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 29/12/21.
//

import Foundation

extension Int {
    /**
     Function needs to throw because the number needs to be coprime with the modulo base in order for the multiplicative inverse to exist.
     - Parameters:
        - modulo: Modulo base corresponding to the set over which the inverse is computed
     - Returns: Multiplicative inverse of the number upon which the funtion is called upon- multiplying original number with the output modulo base will result in `1`.
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     # Reference: [Modular inverses](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-inverses)
     */
    public func multiplicativeInverse(modulo base: Int) throws -> Int  {
        guard NumberTheory.euclidsAlgorithm(self, base) == 1 else { throw NumberTheory.ModuloArithmaticError.inputIsNotCoprimeWithModuloBase }
           
        let (_ , _, b) = NumberTheory.ExtendedEuclidsAlgorithm(self, base).evaludate()
        
        return b
    }
}
