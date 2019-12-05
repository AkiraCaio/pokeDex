//
//  StringProtocol.swift
//  pokeDex
//
//  Created by akiracaio on 04/12/19.
//  Copyright © 2019 akiracaio. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
