//
//  Concentration.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/16/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
     //   randomizeArray(input: cards)
    }
    
/*    func randomizeArray(input array: Array<Card>) {
        var tempCards = [Card]()
        
        // Initialize a new temporary array
        for iterator in array.indices {
            tempCards[iterator] = Card()
        }
        
        for old_index in array.indices {
            while true {
                let
            }
        }
        
    }*/
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
}
