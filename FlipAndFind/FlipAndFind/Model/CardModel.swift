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
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "dinosaurio"
    }
    
    case alamosaurus, amargasaurus, ankylosaurus, apatosaurus, brachiosaurus, dimorphodon, gallimimus, gargoyleosaurus, lambeosaurus, parasaurolophus, pteranodon, spinosaurus, stegosaurus, styracosaurus, trex, triceratops
}

enum SeaAnimals: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "seaanimals"
    }
    
    case angelfish, cancerhermit, clownfish, crab, dolphin, hornedzankle, jellyfish, octopus, oyster, rapan, seahorse, seaturtle, shrimp, starfish, surgeonfish, zebrafish
}

enum Halloween: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "halloween"
    }
    
    case witch, ghost, skeleton, werewolf, zombi, vampire, jacklantern, mummy, owl, potion, blackcat, witchhat, witchsbroom, pumpkin, trickortreat
}

enum Farm: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "farm"
    }
    
    case cat, chicken, cow, dog, donkey, goat, goose, horse, mouse, pato, pig, ram, rooster, sheep, turkey
}

enum Insects: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "insects"
    }
    
    case snail, grasshopper, spider, butterfly, cockroach, dragonfly, mosquito, bee, worm, fly, caterpillar, mantis, ladybug, blackant, redant,rhinocerosbeetle
}

enum Jungle: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "jungle"
    }
    
    case panther, lion, monkey, elephant, crocodile, leopard, gorilla, giraffe, koala, sloth, toucan, panda, hummingbird, chameleon
}
