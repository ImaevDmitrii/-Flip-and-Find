//
//  GameModel.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import Foundation

final class GameModel {
    
    var cards: [CardModel] = []
    var isCheckingMatches = false
    var firstFlippedCardIndex: Int?
    
    func setupGame(numberOfPairs: Int, factory: CardTypeFactory) {
        cards = factory.createCards(numberOfPairs: numberOfPairs).shuffled()
    }
    
    func flipCard(index: Int) {
        guard !cards[index].isFlipped, !cards[index].isMatched else { return }
        
        cards[index].isFlipped = true
        
        if let firstIndex = firstFlippedCardIndex, cards[firstIndex].cardType.imageName != cards[index].cardType.imageName {
            isCheckingMatches = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.flipBack(firstIndex: firstIndex, secondIndex: index)
            }
        } else if let firstIndex = firstFlippedCardIndex, cards[firstIndex].cardType.imageName == cards[index].cardType.imageName {
            cards[firstIndex].isMatched = true
            cards[index].isMatched = true
            isCheckingMatches = false
            firstFlippedCardIndex = nil
        } else {
            firstFlippedCardIndex = index
        }
    }
    
    func flipBack(firstIndex: Int, secondIndex: Int) {
        [firstIndex, secondIndex].forEach { index in
            if !cards[index].isMatched {
                cards[index].isFlipped = false
            }
        }
        isCheckingMatches = false
        firstFlippedCardIndex = nil
    }
    
    func checkAllPairsFound() -> Bool {
        cards.allSatisfy { $0.isMatched }
    }
}
