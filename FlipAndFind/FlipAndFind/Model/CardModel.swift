//
//  Card.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import Foundation

protocol CardType {
    var imageName: String { get }
    var backImage: String { get }
}

struct CardModel {
    var id: Int
    var isFlipped = false
    var isMatched = false
    var cardType: CardType
    
    var imageName: String {
        isFlipped ? cardType.imageName : cardType.backImage
    }
}

enum DinosaurType: String, CaseIterable, CardType {
    case alamosaurus, amargasaurus, ankylosaurus, apatosaurus, brachiosaurus, dimorphodon, gallimimus, gargoyleosaurus, lambeosaurus, parasaurolophus, pteranodon, spinosaurus, stegosaurus, styracosaurus, trex, triceratops
    
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "dinosaurio"
    }
}
