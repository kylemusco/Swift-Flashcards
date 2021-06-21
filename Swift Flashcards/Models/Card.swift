//
//  Card.swift
//  Swift Flashcards
//
//  Created by Kyle Musco on 6/5/21.
//

import Foundation

class Card {
    enum Category: String {
        case Accessibility
        case Database
        case Debugging
        case DesignPattern
        case General
        case Memory
        case Networking
        case ObjectiveC
        case Swift
        case Threads
        case UIKit
    }
    
    var question: String
    var answer: String
    var category: Category
    var attempts: Int
    var successfulAnswers: Int
    
    init(question: String, answer: String, category: Category) {
        self.question = question
        self.answer = answer
        self.category = category
        self.attempts = 0
        self.successfulAnswers = 0
    }
}
