//
//  Card.swift
//  FlipAndFind
//
//  Created by Dmitrii Imaev on 22.04.2024.
//

import Foundation

struct CardModel {
    var id: Int
    var isFlipped = false
    var isMatched = false
    var dinosaurType: DinosaurType

    static let backImageName = "dinosaurio"
    
    var imageName: String {
        isFlipped ? dinosaurType.imageName : CardModel.backImageName
    }
}

enum DinosaurType: String, CaseIterable {
    case alamosaurus = "alamosaurus"
    case amargasaurus = "amargasaurus"
    case ankylosaurus = "ankylosaurus"
    case apatosaurus = "apatosaurus"
    case brachiosaurus = "brachiosaurus"
    case dimorphodon = "dimorphodon"
    case gallimimus = "gallimimus"
    case gargoyleosaurus = "gargoyleosaurus"
    case lambeosaurus = "lambeosaurus"
    case parasaurolophus = "parasaurolophus"
    case pteranodon = "pteranodon"
    case spinosaurus = "spinosaurus"
    case stegosaurus = "stegosaurus"
    case styracosaurus = "styracosaurus"
    case trex = "trex"
    case triceratops = "triceratops"
    
    var imageName: String {
        self.rawValue
    }
}
