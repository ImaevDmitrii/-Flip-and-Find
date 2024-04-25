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
        let shuffledTypes = types.shuffled()
        let limitedPairs = min(numberOfPairs, shuffledTypes.count)
        
        var cards = [CardModel]()
        for id in 0..<limitedPairs {
            let type = shuffledTypes[id]
            let cardId = Int(UUID().hashValue)
            let card1 = CardModel(id: cardId, cardType: type)
            let card2 = CardModel(id: cardId, cardType: type)
            cards.append(contentsOf: [card1, card2])
        }
        return cards
    }
}
