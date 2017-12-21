//
//  Concentration.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/16/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): Int): Number of pairs of cards must be > 0")
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
    
     private func randomizeArray() {
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
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
}
