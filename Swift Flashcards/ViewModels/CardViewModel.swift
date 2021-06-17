//
//  CardViewModel.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/5/21.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var nextCard: Card?
    @Published var numCorrect: Int
    @Published var numAnswered: Int
    @Published var isOver: Bool
    
    private var cardIndex: Int
    private let cardController: CardController
    
    init(cardController: CardController = CardController()) {
        self.cardController = cardController
        self.nextCard = nil
        self.numCorrect = 0
        self.numAnswered = 0
        self.cardIndex = 0
        self.isOver = false
        
        loadCards()
    }
    
    func loadCards() {
        self.cards = cardController.loadCardsFromPlist()
        self.nextCard = self.cards.first
    }
    
    func getNextCard() {
        if (cardIndex < cards.count-1) {
            cardIndex += 1
        } else {
            isOver = true
        }
        
        self.nextCard = cards[cardIndex]
    }
    
    func incrementScore() {
        self.numCorrect += 1
    }
    
    func incrementProgress() {
        self.numAnswered += 1
    }
    
    func reset() {
        self.cards.shuffle()
        self.numCorrect = 0
        self.numAnswered = 0
        self.cardIndex = 0
        self.isOver = false
    }
}
