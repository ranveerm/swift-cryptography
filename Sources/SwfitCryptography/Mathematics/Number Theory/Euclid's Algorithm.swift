//
//  Euclid's Algorithm
//
//
//  Created by ranveerm on 27/12/21.
//

import Foundation

public extension NumberTheory { }

// MARK: Nested Types
extension NumberTheory {
    /**
     Capture parametes for greatest common denominator operation for 2 integers.
     
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
