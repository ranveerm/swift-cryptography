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
    func multipleRemainder(for argument: Int, modBase: Int) {
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
}

fileprivate extension NumberTheory {
    func inputlabel(_ input: Int) -> String {
        "mod \(input)"
    }
}
