//
//  Error.swift
//  Tamagotchi
//
//  Created by 김지연 on 2023/08/17.
//

import Foundation

enum ValidationError: Error {
    case emptyInput
    case isMinInput
    case isMaxInput
    case isNotInt
}


