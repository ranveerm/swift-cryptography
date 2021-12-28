//
//  Extended Euclid's Algorithm
//
//
//  Created by ranveerm on 27/12/21.
//

import Foundation

public extension NumberTheory {
    /**
     Object to implement Extended Euclid's Algorithm.
     
     Naming scheme used-
     ```
     GCD(a, b) =  x * a + y * b
     ```
     
     As opposed to Euclid's Algorithm, the extended version is implemented within an object (as opposed to a `static func`) because capturing state (original inputs) simplifies the main recursive function.
     
     While the algorithm will always have return a valid output
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     # Reference: [Introduction to Public-Key Cryptography](https://www.youtube.com/watch?v=TCwciYgO6zI&t=3387s)
     */
    struct ExtendedEuclidsAlgorithm {
        public typealias Output = (gcd: Int, x: Int, y: Int)
        typealias GCDParameters = NumberTheory.GCDParameters
        
        let a: Int
        let b: Int
        
        public init(_ input1: Int, _ input2: Int) {
            let gcdParamters = GCDParameters(input1, input2)
            self.a = gcdParamters.largerInput
            self.b = gcdParamters.smallerInput
        }
        
        public func evaludate() -> Output {
            evaludateRecursively(aIteration: a, bIteration: b)
        }
    }
}

// MARK: Algorithm Implementation
extension NumberTheory.ExtendedEuclidsAlgorithm {
    /**
     Extended Euclidean Algorithm implemented as a recursive function. A recursive iteration is based on an iteration from the regual Euclid's Algorithm. Every iteration determines the linear combination of the remainder with respect to the origina inputs.
     
     The actions undertaken at a particular iteration of a recursion fall into 5 main branhces
     - **Special Cases**-
        - Equal inputs
        - One of the inputs is `0`
     - **First iteration**- special case where all the information needed is available within the current iteration
     - **Second iteration**- special case where all the information needed is avilabe in the current itearation and the previous iteration
     - **Regular iteration**- information from the previous iteration and the iteration before that is required. The rationale behind this is-
        1. Regular Eulid's algorithm for the current iteration utilises remainders from the previous iteration and the iteration before that (see image below).
        2. Given that the remainder is represented as a linear combination of the original inputs at each iteration, this information can be used to substitue the expression from 1.
        3. 1. and 2. results in the the remainder for Euclid's algorithm for the current iteration to be represented as a linear combination of the original inputs.
     - **Termination iteration**- termination condition has been met (remainder for the current iteration is `0`)
     ```
     ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐      ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐
                                                                                                                                                                     
     │                                                                                                       │      │                                               │
                                                                                                                                                                     
     │                                          Euclid's Algorithm                                           │      │              "Extended Algorithm"             │
                                                                                                                                Representing remainder as a
     │                                                                                                       │      │              linear combination of            │
                                                                                                                                      original inputs
     │                                                                                                       │      │                                               │
                                                                                                                                                                     
     │                                                                                                       │      │                                               │
            ┌───────────────────┐
     │      │        GCD        │                                                                            │      │                                               │
            │  ┌─────┐  ┌─────┐ │
     │      │  │  a  │  │  b  │─┼──────────────────────────────────────────────┐                             │      │                                               │
            │  └──┬──┘  └─────┘ │                                              │
     │      │     └─────────────┼──────────┐                                   │                             │      │                                               │
            └───────────────────┘          ▼                                   ▼
     │                               ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐ │      │  ┌─────┐     ┌─────┐     ┌─────┐    ┌─────┐   │
                                     │    a     │    -    │    y0    │ * │    b     │     =     │    r0    │     =     │  1  │  *  │  a  │   - │ y0  │  * │  b  │
     │                               └──────────┘         └──────────┘   └──────────┘           └──────────┘ │      │  └─────┘     └─────┘     └─────┘    └─────┘   │
                                                                               │                      │
     │                                                                         │                      │      │      │                                               │
                                                                               │                      │
     │            ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘      │      │                                               │
                  │        │
     │      ┌─────┼────────┼────┐                                                                            │      │                                               │
            │     ▼  GCD   ▼    │
     │      │  ┌─────┐  ┌─────┐ │                                                                            │      │                                               │
            │  │  b  │  │ r0  │─┼──────────────────────────────────────────────┐
     │      │  └──┬──┘  └─────┘ │                                              │                             │      │                                               │
            │     └─────────────┼──────────┐                                   │
     │      └───────────────────┘          │                                   │                             │      │                                               │
                                           ▼                                   ▼
     │                               ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐ │      │  ┌─────┐     ┌─────┐     ┌─────┐    ┌─────┐   │
                                     │    b     │    -    │   y1d    │ * │    r0    │     =     │    r1    │     =     │ x1  │  *  │  a  │   - │ y1  │  * │  b  │
     │                               └──────────┘         └──────────┘   └──────────┘           └──────────┘ │      │  └─────┘     └─────┘     └─────┘    └─────┘   │
                                                                               │                      │
     │                                                                         │                      │      │      │                                               │
                                                                               │                      │
     │            ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘      │      │                                               │
                  │        │
     │            │        │                                                                                 │      │                                               │
            ┌─────┼────────┼────┐
     │      │     ▼  GCD   ▼    │                                                                            │      │                                               │
            │  ┌─────┐  ┌─────┐ │
     │      │  │ r0  │  │ r1  │─┼──────────────────────────────────────────────┐                             │      │                                               │
            │  └──┬──┘  └─────┘ │                                              │
     │      │     └─────────────┼──────────┐                                   │                             │      │                                               │
            └───────────────────┘          │                                   │
     │                                     ▼                                   ▼                             │      │                                               │
                                     ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐           ┌─────┐     ┌─────┐     ┌─────┐    ┌─────┐
     │                               │    r0    │    -    │   y2d    │ * │    r1    │     =     │    r2    │ │   =  │  │ x2  │  *  │  a  │   - │ y2  │  * │  b  │   │
                                     └──────────┘         └──────────┘   └──────────┘           └──────────┘           └─────┘     └─────┘     └─────┘    └─────┘
     │                                                                         │                      │      │      │                                               │
                                                                               │                      │
     │                                                                         │                      │      │      │                                               │
                                                                               │                      │
     │            ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘      │      │                                               │
                  │        │
     │            │        │                                                                                 │      │                                               │
                  │        │
     │            │        │                                                                                 │      │                                               │
        ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                       Recursive Process                                       │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  │                                                                                               │    │      │                                               │
        │                                                                                               │
     │  └───────────────────────────────────────────────────────────────────────────────────────────────┘    │      │                                               │
                  │          │
     │            └──────────┴────────────┬───────────────────────────────────┐                              │      │                                               │
                                          │                                   │
     │                                    ▼                                   ▼                              │      │                                               │
                                    ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐           ┌───────┐   ┌─────┐     ┌───────┐   ┌─────┐
     │                              │ r{l - 1} │    -    │yd{l - 1} │ * │ r{l - 1} │     =     │    rl    │  │  =   │ │xl -> x│ * │  a  │   - │yl -> y│ * │  b  │   │
                                    └──────────┘         └──────────┘   └──────────┘           └──────────┘           └───────┘   └─────┘     └───────┘   └─────┘
     │                                                                        │                      │       │      │                                               │
                                                                              │                      │
     │                                                                        │                      │       │      │                                               │
                 ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘
     │           │        │                                                                                  │      │                                               │
                 │        │
     │     ┌─────┼────────┼────┐                                                                             │      │                                               │
           │     ▼  GCD   ▼    │
     │     │┌────────┐ ┌─────┐ │                                                                             │      │                                               │
           ││r{l - 1}│ │ rl  │─┼───────────────────────────────────────────────┐
     │     │└────┬───┘ └─────┘ │                                               │                             │      │                                               │
           │     └─────────────┼───────────┐                                   │
     │     └───────────────────┘           ▼                                   ▼                             │      │                                               │
                                     ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
     │                               │ r{l - 1} │    -    │yd{l - 1} │ * │rl -> GCD │     =     │    0     │ │      │                                               │
                                     └──────────┘         └──────────┘   └──────────┘           └──────────┘
     │                                                                                                       │      │                                               │
                                                                                                                                                                     
     │                                                                                                       │      │                                               │
      ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─        ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
     ```
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     */
    private func evaludateRecursively(aIteration: Int, bIteration: Int,
                                      diophantineCoefficients: DiophantineCoefficients? = nil,
                                      previousDiophantineCoefficients: DiophantineCoefficients? = nil) -> Output {
        /// Special case- one of the inputs is `0`
        if bIteration == 0 { return (0, 0, 0) }
        /// Special case- equal inputs
        if aIteration == bIteration { return (aIteration, 1, 0) }
        
        let gcdParametersCurrentIteration = GCDParameters(aIteration, bIteration)
        
        
        /// First Iteration
        guard let diophantineCoefficients = diophantineCoefficients else {
            return firstIteration(gcdParametersIteration: gcdParametersCurrentIteration)
        }
        
        /// Termination Condition
        if gcdParametersCurrentIteration.remainder == 0 {
            let gcd = gcdParametersCurrentIteration.smallerInput
            return (gcd, diophantineCoefficients.x, diophantineCoefficients.y)
        }
        
        /// Second iteration
        guard let previousDiophantineCoefficients = previousDiophantineCoefficients else {
            return secondIteration(gcdParametersIteration: gcdParametersCurrentIteration, diophantineCoefficients: diophantineCoefficients)
        }
        
        return regularIteration(gcdParametersIteration: gcdParametersCurrentIteration,
                                diophantineCoefficients: diophantineCoefficients,
                                previousDiophantineCoefficients: previousDiophantineCoefficients)
    }
    
    // MARK: First Iteration
    /**
     First iteration of Extended Euclidean Algorithm.
     
     ```
     a = gcdParametersIteration.dividend * b + r0
     r0 = 1 * a - gcdParametersIteration.dividend * b -> x0 = 1 and y0 = - gcdParametersIteration.dividend
     ```
     */
    private func firstIteration(gcdParametersIteration: GCDParameters) -> Output {
        let diophantineCoefficients = DiophantineCoefficients(x: 1, y: -1 * gcdParametersIteration.dividend)
        return evaludateRecursively(aIteration: gcdParametersIteration.smallerInput,
                                    bIteration: gcdParametersIteration.remainder,
                                    diophantineCoefficients: diophantineCoefficients)
    }
    
    // MARK: Second Iteration
    /**
     Second iteration of Extended Euclidean Algorithm.
     
     ```
     b = gcdParametersIteration.dividend * r0 + r1
     r1 = b - gcdParametersIteration.dividend * r0, where x0 = 1 and y0 = - gcdParametersIteration.dividend for r0
     x1 = -gcdParametersIteration.dividend, y2 = 1 - (y0  * -gcdParametersIteration.dividend)
     ```
     */
    private func secondIteration(gcdParametersIteration: GCDParameters,
                                 diophantineCoefficients: DiophantineCoefficients) -> Output {
        let xIteration = diophantineCoefficients.x * gcdParametersIteration.dividend * -1
        let yIteration = 1 - diophantineCoefficients.y * gcdParametersIteration.dividend
        let diophantineCoefficientsCurrent = DiophantineCoefficients(x: xIteration, y: yIteration)
        
        return evaludateRecursively(aIteration: gcdParametersIteration.smallerInput,
                                    bIteration: gcdParametersIteration.remainder,
                                    diophantineCoefficients: diophantineCoefficientsCurrent,
                                    previousDiophantineCoefficients: diophantineCoefficients)
    }
    
    // MARK: Regular Iteration
    /**
     Regular iteration of Extended Euclidean Algorithm.
     
     ```
     r{i - 2} = r{i - 1) * gcdParametersIteration.dividend + ri
     ri = r{i - 2} - r{i - 1) * gcdParametersIteration.dividend
     xi = x{i -2} - gcdParametersIteration.dividend * x{i - 1}
     yi = y{i -2} - gcdParametersIteration.dividend * y{i - 1}
     ```
     */
    private func regularIteration(gcdParametersIteration: GCDParameters,
                                  diophantineCoefficients: DiophantineCoefficients,
                                  previousDiophantineCoefficients: DiophantineCoefficients) -> Output {
        let xIteration = previousDiophantineCoefficients.x - gcdParametersIteration.dividend * diophantineCoefficients.x
        let yIteration = previousDiophantineCoefficients.y - gcdParametersIteration.dividend * diophantineCoefficients.y
        let diophantineCoefficientsCurrent = DiophantineCoefficients(x: xIteration, y: yIteration)
        
        return evaludateRecursively(aIteration: gcdParametersIteration.smallerInput,
                                    bIteration: gcdParametersIteration.remainder,
                                    diophantineCoefficients: diophantineCoefficientsCurrent,
                                    previousDiophantineCoefficients: diophantineCoefficients)
    }
}

// MARK: Nested Types
extension NumberTheory.ExtendedEuclidsAlgorithm {
    /**
     Coefficients for the equation `c = a * x + b * y`
     */
    private struct DiophantineCoefficients {
        let x: Int
        let y: Int
    }
}
