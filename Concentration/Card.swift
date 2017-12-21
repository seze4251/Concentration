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
    private(set) var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueCardIdentifier()-> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueCardIdentifier()
    }
}
