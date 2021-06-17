//
//  CardController.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/5/21.
//

import Foundation

class CardController {
    func loadCardsFromPlist() -> [Card] {
        if let path = Bundle.main.path(forResource: "Cards", ofType: "plist") {
            if let cardsFromFile = NSArray(contentsOfFile: path) as? [NSDictionary] {
                var cards = [Card]()
                
                for card in cardsFromFile {
                    cards.append(Card.init(question: card["question"] as! String,
                                           answer: card["answer"] as! String,
                                           category: Card.Category.init(rawValue: card["category"] as! String)!))
                }
                
                // Shuffle cards
                cards.shuffle()
                
                return cards
            } else {
                print("Error loading cards from plist")
            }
        }
        
        return [Card]()
    }
}
