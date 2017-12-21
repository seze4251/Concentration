//
//  ViewController.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/13/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Num Touches = \(flipCount)"
        }
    }
    
     @IBOutlet private weak var flipCountLabel: UILabel!

     @IBOutlet private var cardButtons: [UIButton]!
    
     @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            if (game.isFinished()) {
                // Display Restart Button
                restartButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        } else {
            print("Button has not been linked to list")
        }
    }
    
     @IBOutlet private weak var restartButton: UIButton!
    
     @IBAction private func playAgain(_ sender: UIButton) {
        if (!game.isFinished()) {
            return
        }
        
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        restartButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        updateViewFromModel()
        
        // Put all Emojis back inside emoji choices
        for (_, value) in emoji {
            emojiChoices.append(value)
        }
        
        // Clear Emoji Dictonary
        emoji.removeAll()
        
        // Reset Flipcount
        flipCount = 0
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            print("Index: \(index), isFaceUp: \(card.isFaceUp)")
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["👻", "🎃", "🇱🇷", "🍸", "🔥", "🦄", "🙉", "🤷🏻‍♂️", "🎅🏿"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at:emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random : Int {
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

