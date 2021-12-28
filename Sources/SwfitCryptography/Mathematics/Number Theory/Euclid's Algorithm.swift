//
//  Euclid's Algorithm
//
//
//  Created by ranveerm on 27/12/21.
//

import Foundation

public extension NumberTheory {
    /**
     Recursive function to compute GCD
     
     In addition to allocating the input integers to the respective properties based on their size, this object provdies the following handly computations-
       - Number of time the smaller input divides the larger input
       - Remainder when the smaller input divides the larger input
     
     Process-
     ```
     ┌───────────────────┐
     │        GCD        │
     │  ┌─────┐  ┌─────┐ │
     │  │  a  │  │  b  │─┼──────────────────────────────────────────────┐
     │  └──┬──┘  └─────┘ │                                              │
     │     └─────────────┼──────────┐                                   │
     └───────────────────┘          ▼                                   ▼
                              ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
                              │    a     │    -    │    y0    │ * │    b     │     =     │    r0    │
                              └──────────┘         └──────────┘   └──────────┘           └──────────┘
                                                                        │                      │
                                                                        │                      │
                                                                        │                      │
           ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘
           │        │
     ┌─────┼────────┼────┐
     │     ▼  GCD   ▼    │
     │  ┌─────┐  ┌─────┐ │
     │  │  b  │  │ r0  │─┼──────────────────────────────────────────────┐
     │  └──┬──┘  └─────┘ │                                              │
     │     └─────────────┼──────────┐                                   │
     └───────────────────┘          │                                   │
                                    ▼                                   ▼
                              ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
                              │    b     │    -    │   y1d    │ * │    r0    │     =     │    r1    │
                              └──────────┘         └──────────┘   └──────────┘           └──────────┘
                                                                        │                      │
                                                                        │                      │
                                                                        │                      │
           ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘
           │        │
           │        │
     ┌─────┼────────┼────┐
     │     ▼  GCD   ▼    │
     │  ┌─────┐  ┌─────┐ │
     │  │ r0  │  │ r1  │─┼──────────────────────────────────────────────┐
     │  └──┬──┘  └─────┘ │                                              │
     │     └─────────────┼──────────┐                                   │
     └───────────────────┘          │                                   │
                                    ▼                                   ▼
                              ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
                              │    r0    │    -    │   y2d    │ * │    r1    │     =     │    r2    │
                              └──────────┘         └──────────┘   └──────────┘           └──────────┘
                                                                        │                      │
                                                                        │                      │
                                                                        │                      │
                                                                        │                      │
           ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘
           │        │
           │        │
           │        │
           │        │
 ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                       Recursive Process                                       │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 │                                                                                               │
 └───────────────────────────────────────────────────────────────────────────────────────────────┘
           │          │
           └──────────┴────────────┬───────────────────────────────────┐
                                   │                                   │
                                   ▼                                   ▼
                             ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
                             │ r{l - 1} │    -    │yd{l - 1} │ * │ r{l - 1} │     =     │    rl    │
                             └──────────┘         └──────────┘   └──────────┘           └──────────┘
                                                                       │                      │
                                                                       │                      │
                                                                       │                      │
          ┌────────┬───────────────────────────────────────────────────┴──────────────────────┘
          │        │
          │        │
    ┌─────┼────────┼────┐
    │     ▼  GCD   ▼    │
    │┌────────┐ ┌─────┐ │
    ││r{l - 1}│ │ rl  │─┼───────────────────────────────────────────────┐
    │└────┬───┘ └─────┘ │                                               │
    │     └─────────────┼───────────┐                                   │
    └───────────────────┘           ▼                                   ▼
                              ┌──────────┐         ┌──────────┐   ┌──────────┐           ┌──────────┐
                              │ r{l - 1} │    -    │yd{l - 1} │ * │rl -> GCD │     =     │    0     │
                              └──────────┘         └──────────┘   └──────────┘           └──────────┘
     ```
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     # Reference: [Introduction to Public-Key Cryptography](https://www.youtube.com/watch?v=TCwciYgO6zI&t=3387s)
     */
    static func euclidsAlgorithm(_ a: Int, _ b: Int) -> Int {
        /// Special Case 1- GCD(a, a)
        if a == b { return a }
        
        let gcdParameters = GCDParameters(a, b)
        
        /// Special Case 2- GCD(a, 0)
        if gcdParameters.smallerInput == 0 { return gcdParameters.largerInput }
    
        /// GCD(b, a % b)
        return euclidsAlgorithm(gcdParameters.smallerInput, gcdParameters.remainder)
    }
}

// MARK: Nested Types
extension NumberTheory {
    /**
     Capture parametes for GCD operation for 2 integers.
     
     In addition to allocating the input integers to the respective properties based on their size, this object provdies the following handly computations-
       - Number of time the smaller input divides the larger input
       - Remainder when the smaller input divides the larger input
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     */
    struct GCDParameters {
        let largerInput: Int
        let smallerInput: Int
        
        init(_ input1: Int, _ input2: Int) {
            if input1 == input2 {
                self.largerInput = input1
                self.smallerInput = input2
            } else {
                self.largerInput = input1 > input2 ? input1 : input2
                self.smallerInput = largerInput == input1 ? input2 : input1
            }
        }
        
        var dividend: Int { largerInput / smallerInput }
        var remainder: Int { largerInput % smallerInput }
    }
}
