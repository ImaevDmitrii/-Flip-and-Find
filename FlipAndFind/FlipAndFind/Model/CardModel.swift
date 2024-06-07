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
    
    case allosaurus, ankylosaurus, baryonyx, brachiosaurus, carnosaurus, diplodocus, elasmosaurus, gallimimus, kronosaurus, ornithosaurus, pterodactyl, spinosaurus, stegosaurus, triceraptor, tyrannosaurus, velociraptor
}

enum SeaAnimalsType: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "seaanimals"
    }
    
    case clownFish, crab, dolphin, hammerheadShark, jellyfish, killerWhale, stingray, octopus, oyster, hedgehogFish, shark, shrimp, squid, swordfish, turtle, whale
}

enum HalloweenType: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "halloween"
    }
    
    case bat, blackCat, death, ghost, monster, mummy, owl, pirate, pumpkin, skeleton, blackSpider, vampire, werewolf, witchHat, witch, zombie
}

enum FarmType: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "farm"
    }
    
    case cat, cow, dog, donkey, duck, goat, goose, hen, horse, mouse, pig, rabbit, ram, rooster, sheep, turkey
}

enum InsectsType: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "insects"
    }
    
    case ant, bee, butterfly, caterpillar, cockroach, dragonfly, flea, fly, grasshopper, ladybug, mantis, mosquito, rhinocerosBeetle, stagBeetle, spider, snail
}

enum JungleType: String, CaseIterable, CardType {
    var imageName: String {
        self.rawValue
    }
    
    var backImage: String {
        "jungle"
    }
    
    case hummingbird, crocodile, elephant, hippopotamus, giraffe, leopard, lion, monkey, panther, tiger, zebra, gorilla, parrot, flamingo, lemur, rhinoceros
}
