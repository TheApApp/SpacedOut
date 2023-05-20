//
//  CoreDataHelpers.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import CoreData

// create wrappers to make core data non-optional

extension Category {
    var categoryName: String {
        get { name ?? "(Unnamed Category)"}
        set { name = newValue }
    }
    
    var categoryCreationDate: Date {
        get { creationDate ?? .now }
        set { creationDate = newValue }
    }
    
    var categoryCards: [Card] {
        let array = cards?.allObjects as? [Card] ?? []
        return array.sorted()
    }
}

extension Card {
    var cardFront: String {
        get { front ?? "Card Front"}
        set { front = newValue }
    }
    
    var cardBack: String {
        get { back ?? "Card Back"}
        set { back = newValue }
    }
    
    var cardCreationData: Date {
        get { creationDate ?? .now }
        set { creationDate = newValue }
    }
}

extension Card: Comparable {
    public static func <(lhs: Card, rhs: Card) -> Bool {
        if lhs.cardFront == rhs.cardFront {
            if lhs.cardBack == rhs.cardBack {
                return lhs.cardCreationData < rhs.cardCreationData
            } else {
                return lhs.cardBack < rhs.cardBack
            }
        } else {
            return lhs.cardFront < rhs.cardFront
        }
    }
}
