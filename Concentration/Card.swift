//
//  Card.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/16/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import Foundation

struct Card {
   // var isSet = false
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueCardIdentifier()-> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueCardIdentifier()
    }
}
