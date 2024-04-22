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
    
    func setupGame(numberOfPairs: Int) {
        let numberOfPairs = min(numberOfPairs, DinosaurType.allCases.count)
        
        let shuffledDinosaurs = DinosaurType.allCases.shuffled()
        
        cards = (0..<numberOfPairs).flatMap { id -> [CardModel] in
            let dinosaurType = shuffledDinosaurs[id]
            let card = CardModel(id: id, dinosaurType: dinosaurType)
            return [card, card]
        }.shuffled()
    }
    
    
    func flipCard(index: Int) {
        guard !cards[index].isFlipped, !cards[index].isMatched else { return }
        
        cards[index].isFlipped = true
        
        if let firstIndex = firstFlippedCardIndex {
            isCheckingMatches = true
            
            if firstIndex != index && cards[firstIndex].dinosaurType != cards[index].dinosaurType {
                
            } else if cards[firstIndex].dinosaurType == cards[index].dinosaurType {
                cards[firstIndex].isMatched = true
                cards[index].isMatched = true
                isCheckingMatches = false
                firstFlippedCardIndex = nil
            }
        } else {
            firstFlippedCardIndex = index
        }
    }
    
    func flipBack() {
        guard isCheckingMatches else { return }
        for index in 0..<cards.count where !cards[index].isMatched && cards[index].isFlipped {
            cards[index].isFlipped = false
        }
        isCheckingMatches = false
        firstFlippedCardIndex = nil
    }
    
    func checkAllPairsFound() -> Bool {
        cards.allSatisfy { $0.isMatched }
    }
}
