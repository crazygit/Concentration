//
//  Concentration.swift
//  Concentration
//
//  Created by crazygit on 2018/12/12.
//  Copyright © 2018 crazygit. All rights reserved.
//

import Foundation


class Concentration {
    var cards = [Card]()

    var indexOfOneAndOnlyFaceUpCard: Int? = nil

    func choosedCard(at index: Int) {
        if !(cards[index].isMatched) {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }

        // TODO: Shuffle the cards
        cards.shuffle()
    }
}
