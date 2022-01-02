//
//  Fast Modular Exponentiation.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 2/1/2022.
//

import Foundation
import BigInt

public extension BigInt {
    /**
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     # Reference: [Modular exponentiation](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-exponentiation)
     */
    func fastModularExponentiation(pow: BigInt, mod modBase: BigInt) -> BigInt {
        FastModularExponentiation(base: self, exponent: pow, modBase: modBase).compute()
    }
    
    /**
     Object to implement fast modulo arithmatic exponentiation.
     
     The rationale behind creating an object for this process is that the **algorithm used is stateful**, and performing this is a standalone function is not very readable.
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     */
    private class FastModularExponentiation {
        let base: BigInt
        /// Expressed as a `var` to allow bit shifting, which is used to compute `base ^ (k *2^i)`, where `k` is the location of the bit i steps from the least significant bit. Given the main algorithm is implemented within a `for` loop, bit shifting is performed along with bitwise-and operation (with `0b1`) at each iteration `i` to extract `k`
        var exponent: BigInt
        let modBase: BigInt
        
        init(base: BigInt, exponent: BigInt, modBase: BigInt) {
            self.base = base
            self.exponent = exponent
            self.modBase = modBase
        }
        
        lazy var reducedBase: BigInt = base % modBase
        
        var exponentiationAtIteration: BigInt = 1
        lazy var exponentiationResultAtIteration: BigInt = 1
        
        /**
         Exponentiation as part of modular arithmatic leveraging the propoerty `a^k mod p = (a ^ m mod p * a ^ n mod p) mod p, where k = m + n` to break down large powers (and leveraging the efficiency of computing `a ^ 2^k`, where each successive `k` is computed by multiplying the computed value from the previous iteration by itself). Recursion is then applied over the above concept.
         
         Algorithm-
         1. Use the power `k` in binary form- `k = k0 * 2^0 + k1 * 2^1 + ... kn * 2^n`, where `n + 1` represents the number of binary digits required to represent `k`
         2. From the above, the input `x` then becomes `x ^ k mod p = x ^ (k0 * 2^0 + k1 * 2^1 + ... kn * 2^n) mod p`
         3. Step 2. can alternatively be represented as `x ^ (k0 * 2^0) + x ^ (k2 * 2^1) + ... x ^ (kn * 2^n)`
         4. Starting from `i = 0`, compute each `x ^ (ki * 2^i)` (even if `k = 0`, as the output is required for subsequent computations) by leveraging the property at the top
         5. Compute the exponentiation of `x` up until the current iteration of `i` by using 4.
         6. Repeat 4. for the next iteration of `i`, passing on-
            i. Value from Step 5.
            ii. Value from Step 4.
         
         Special Cases-
         1. Exponent is `0`- return `1`
         2. Exponent is `1`- return modulo reduced base
         - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
         # Reference: [Modular exponentiation](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-exponentiation)
         */
        func compute() -> BigInt {
            /// Special Case 1.
            guard exponent > 0 else { return exponentiationResultAtIteration }
            /// Special Case 2.
            guard exponent > 1 else { return reducedBase }
            
            for iteration in (0...exponent.bitWidth - 1) {
                if iteration == 0 {
                    exponentiationAtIteration = reducedBase
                } else {
                    /// `base ^ 2^k = base ^(k + k) = base ^ k * base ^ k`, where `base ^ k` is computed in the previous iteration
                    exponentiationAtIteration = (exponentiationAtIteration * exponentiationAtIteration) % modBase
                }
                
                let applyMultiplierAtIteration = (BigInt(exponent) & 0b1) == 1
                exponentiationResultAtIteration = applyMultiplierAtIteration ? (exponentiationResultAtIteration * exponentiationAtIteration) % modBase  : exponentiationResultAtIteration
                exponent >>= 1
            }
            
            return exponentiationResultAtIteration
        }
    }
}
