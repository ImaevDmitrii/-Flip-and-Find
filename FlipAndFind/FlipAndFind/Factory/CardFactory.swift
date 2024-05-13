//
//  CardFactory.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 24.04.2024.
//

import Foundation

protocol CardTypeFactory {
    func createCards(numberOfPairs: Int) -> [CardModel]
}

struct CardFactory: CardTypeFactory {
    private let types: [CardType]
    
    init(types: [CardType]) {
        self.types = types
    }
    
    func createCards(numberOfPairs: Int) -> [CardModel] {
        var cards = [CardModel]()
        
        let availableTypes = types.shuffled()
        var currentPairIndex = 0
        
        while cards.count < numberOfPairs {
            let type = availableTypes[currentPairIndex % availableTypes.count]
            let cardId = Int(UUID().hashValue)
            let card1 = CardModel(id: cardId, cardType: type)
            let card2 = CardModel(id: cardId, cardType: type)
            cards.append(contentsOf: [card1, card2])
            currentPairIndex += 1
        }
        return cards.shuffled()
    }
}
