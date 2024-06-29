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
    var soundName: String { get }
}

extension CardType where Self: RawRepresentable, Self.RawValue == String {
    var imageName: String {
        return rawValue
    }
    
    var soundName: String {
        let languageCode = UserDefaults.standard.string(forKey: "language") ?? "en"
        return "audio_\(rawValue)_\(languageCode)"
    }
    
    var backImage: String {
        return String(describing: Self.self).lowercased()
    }
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


enum Birds: String, CaseIterable, CardType {
    case blackbird, bullfinch, capercaillie, crow, eagle, gull, heron, magpie, nightingale, owl, greenParrot, penguin, pigeon, puffin, sparrow, stork, swallow, swan, waxwing, woodpecker
}

enum Dinosaur: String, CaseIterable, CardType {
    case сorythosaurus, allosaurus, ankylosaurus, argentinosaurus, baryonyx, brachiosaurus, carnosaurus, dilophasaurus, diplodocus, elasmosaurus, gallimimus, kronosaurus, ornithosaurus, pterodactyl, pteranodon, spinosaurus, stegosaurus, triceraptor, tyrannosaurus, velociraptor
}

enum Farm: String, CaseIterable, CardType {
    case bull, cat, chick, cow, dog, donkey, drake, duck, goat, goose, hen, horse, lama, mouse, pig, rabbit, ram, rooster, sheep, turkey
}

enum Garden: String, CaseIterable, CardType {
    case apple, cabbage, carrot, cherry, corn, cucumber, eggplant, garlic, grape, onion, orange, peach, pear, plum, potato, pumpkin, raspberry, strawberry, tomato, zucchini
}

enum Halloween: String, CaseIterable, CardType {
    case bat, blackCat, death, fairy, frankenstein, gargoyle, ghost, jack, monster, mummy, owlHalloween, pirate, skeleton, spiderHalloween, vampire, werewolf, witch, witchHat, yeti, zombie
}

enum Insect: String, CaseIterable, CardType {
    case ant, bee, butterfly, caterpillar, cockroach, coloradoBeetle, dragonfly, flea, fly, grasshopper, ladybug, mantis, mosquito, moth, pillbug, rhinocerosBeetle, snail, spider, stagBeetle, wasp
}

enum Jungle: String, CaseIterable, CardType {
    case cockatoo, crocodile, elephant, flamingo, gazelle, giraffe, gorilla, hippopotamus, hummingbird, lemur, leopard, lion, monkey, panther, parrot, python, rhinoceros, sloth, tiger, zebra
}

enum Sea: String, CaseIterable, CardType {
    case clownFish, crab, dolphin, hammerheadShark, hedgehogFish, jellyfish, killerWhale, moorishIdol, octopus, oyster, regalBlueTang, seahorse, shark, shrimp, squid, starfish, stingray, swordfish, turtle, whale
}

enum Transport: String, CaseIterable, CardType {
    case airplane, ambulance, bicycle, boat, bulldozer, bus, car, dumpTruck, fireEngine, garbageTruck, harvester, helicopter, liftingCrane, motorbike, policeCar, ship, tractor, train, truck, van
}
