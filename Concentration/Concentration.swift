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
        randomizeArray()
    }
    
    func isFinished() -> Bool {
        var done = true
        for iterator in cards.indices {
            if !cards[iterator].isMatched {
                done = false
            }
        }
        return done
    }
    
     func randomizeArray() {
        var tempCards = [Card]()
        
        // Initialize a new temporary array
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            print("Length of Cards: \(cards.count), RandomIndex: \(randomIndex)")
            tempCards.append(cards.remove(at:randomIndex))
        }
        cards = tempCards
    }
    
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
