//
//  Modulo Grids.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 9/1/2022.
//

import Foundation

public extension NumberTheory {
    /**
     Print modulo values (with the specified base) for the first (n-1) multiples of supplied number.
     
     This function illustrates that if `p` and `q` are coprime, then `p * k mod q` will result in unique values for every `k` over `[1, q-1]`, that is, all the numbers in the range `[1, q-1]` will-
     - Appear only once as a solution to `p * k mod q`
     - All the numbers will appear at as a solution, based on the value of `k` (however, not in the same order as `k`)
     ```
                     mod 17          1   2   3   4   5   6   7   8   9   10  11  12  13  14  15  16
     Multiples of 3

     3                                       3
     6                                                   6
     9                                                               9
     12                                                                          12
     15                                                                                      15
     18                              1
     21                                          4
     24                                                      7
     27                                                                  10
     30                                                                              13
     33                                                                                          16
     36                                  2
     39                                              5
     42                                                          8
     45                                                                      11
     48                                                                                  14

     ```
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     */
    static func multipleRemainder(for argument: Int, modBase: Int) {
        guard modBase > 1 && argument > 2 else { return }
        
        let modBaseRemainders = 1..<modBase
        let modLabel = inputlabel(modBase)
        let modLabelSize = modLabel.count
        
        print(Array(modBaseRemainders).reduce("\t\t\t\t" + modLabel + "\t") { return $0 + "\t\($1)" })
        
        print("Multiples of \(argument)\n")
        
        /// Note that multiple does not correspond to the actual remainder of the mod operation. `modBaseRemainders` is used for it's dimensions.
        for multiple in modBaseRemainders {
            
            let multipleValue = multiple * argument
            let multipleValueLabel = "\(multipleValue)  "
            
            let padding = modLabelSize - multipleValueLabel.count
            print("\(multipleValue)" + String(repeating: "\t", count: 6), terminator: "")
            print(String(repeating: " ", count: padding), terminator: "")
            let remainder = multipleValue % modBase
            print(String(repeating: "\t", count: remainder) + String(remainder))
        }
    }
    
    /**
     Print `k mod p` and `k mod q` for `k` over `[0, p*q]`  (where inputs `p` and `q` are coprime).
     
     ```
                mod 17        0    1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16
        mod 3


        0                     0    18    36    3     21    39    6     24    42    9     27    45    12    30    48    15    33

        1                     34   1     19    37    4     22    40    7     25    43    10    28    46    13    31    49    16

        2                     17   35    2     20    38    5     23    41    8     26    44    11    29    47    14    32    50

     ```
     # Reference: [More words about PWW #25: The Chinese Remainder Theorem](https://mathlesstraveled.com/2019/04/05/more-words-about-pww-25-the-chinese-remainder-theorem/)
     - Author: 👨🏾‍💻 [ranveerm](https://ranveerm.com/about)
     */
    static func moduloGrid(_ input1: Int, input2: Int) {
        guard input1 > 2 && input2 > 2,
              euclidsAlgorithm(input1, input1) == 1 else { return }
        
        let finalValue = input1 * input2 - 1
        
        let input1Label = inputlabel(input1)
        let input1Remainders = 0..<input1
        let input2Label = inputlabel(input2)
        let input2Remainders = 0..<input2
        
        print(Array(input1Remainders).reduce("\t\t" + input1Label + "\t") { return $0 + "\t\($1)" })
        print(input2Label)
        print("\n")
        
        /// `input2` remainders are the primary key because the main loop interates over `input2` (as printed output occur over a horizontal line)
        var remainderGrid = [Int: [Int: Int]]()
        
        for number in 0...finalValue {
            let input1Remainder = number % input1
            let input2Remainder = number % input2
            
            if remainderGrid[input2Remainder] == nil {
                remainderGrid[input2Remainder] = [:]
            }
            remainderGrid[input2Remainder]?[input1Remainder] = number
        }
        
        for input2Remainder in input2Remainders {
            print(input2Remainder, terminator: "\t\t\t\t\t")
            
            for input1Remainder in input1Remainders {
                print(remainderGrid[input2Remainder]?[input1Remainder] ?? "", terminator: "\t")
            }
            
            print("\n")
        }
    }
}

fileprivate extension NumberTheory {
    static func inputlabel(_ input: Int) -> String {
        "mod \(input)"
    }
}
