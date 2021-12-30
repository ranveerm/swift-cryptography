//
//  Modulo Arithmatic Error.swift
//  
//
//  Created by Ranveer Mamidpelliwar on 29/12/21.
//

import Foundation

extension NumberTheory {
    public enum ModuloArithmaticError: LocalizedError, Equatable {
        case inputIsNotCoprimeWithModuloBase
    }
}
