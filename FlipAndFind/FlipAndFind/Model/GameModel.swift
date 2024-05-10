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
    var startTime: Date?
    var timer: Timer?
    var currentTheme: Theme?
    
    func setupGame(numberOfPairs: Int, factory: CardTypeFactory) {
        let themeString = UserDefaults.standard.string(forKey: "theme")
        currentTheme = Theme(rawValue: themeString ?? Theme.dinosaurio.rawValue) ?? .dinosaurio
        cards = factory.createCards(numberOfPairs: numberOfPairs).shuffled()
        startTime = Date()
        startTimer()
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
            checkIfGameIsOver()
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
    
    private func checkIfGameIsOver() {
        if checkAllPairsFound() {
            stopTimer()
            let completionTime = calculateCompletionTime()
            let latestGame = LatestGames(theme: currentTheme ?? .farm, date: Date(), cardCount: cards.count / 2, completionTime: completionTime)
            GameStorage.shared.saveLatestGame(latestGame)
        }
    }
    
    func calculateCompletionTime() -> TimeInterval {
        guard let start = startTime else { return 0 }
        return Date().timeIntervalSince(start)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
        stopTimer()
    }
    
    func resumeTimer() {
        startTimer()
    }
    
    private func updateTimer() {
    }
}
