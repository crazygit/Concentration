//
//  ViewController.swift
//  Concentration
//
//  Created by crazygit on 2018/12/6.
//  Copyright © 2018 crazygit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

                                                                        // 这里会自动转换为Int类型
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1 ) / 2)
    var emojiChoics: Array<String> = ["👻", "🎃", "🍎", "🍌", "🍑", "🍆", "🌽", "🚗", "🐱", "🐔", "🐙", "🌼"]

    // 属性和方法名字可以相同
    var emoji = [Int: String]()

    @IBOutlet weak var flipCountLable: UILabel!

    @IBOutlet var cardButtons: [UIButton]!

    var flipCount: Int = 0 {
        didSet {
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    // MARK: Handle Card Touch Behavior
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            // Controller 设置Model状态
            game.choosedCard(at: cardNumber)
            // 根据Model状态更新View
            updateViewFromModel()
            flipCount += 1
        }
        else {
            print("chose button was not in cardButtons")
        }
    }

    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }


    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoics.count)))
            emoji[card.identifier] = emojiChoics.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
