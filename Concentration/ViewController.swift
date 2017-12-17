//
//  ViewController.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/13/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Num Touches = \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
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
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func playAgain(_ sender: UIButton) {
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
    }
    
    
    func updateViewFromModel() {
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
    
    var emojiChoices = ["👻", "🎃", "🇱🇷", "🍸", "🔥", "🦄", "🙉", "🤷🏻‍♂️", "🎅🏿"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at:randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

