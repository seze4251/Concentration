//
//  ViewController.swift
//  Concentration
//
//  Created by Seth Zegelstein on 12/13/17.
//  Copyright © 2017 Seth Zegelstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numTouches = 0 {
        didSet {
            numTouchesLabel.text = "Num Touches = \(numTouches)"
        }
    }
    
    @IBOutlet weak var numTouchesLabel: UILabel!
    
    var emojiChoices = ["👻", "🎃", "👻", "🎃"]

    @IBOutlet var cardPictures: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        numTouches += 1
        if let index = cardPictures.index(of: sender) {
            flipCard(withEmoji: emojiChoices[index], on: sender)
        } else {
            print("Button has not been linked to list")
        }
    }
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("emoji = \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

