//
//  Deck.swift
//  Uniq
//
//  Created by Steven Gusev on 20/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import GameplayKit

struct CardsData: Decodable {
    var cards: [CardData]
}

struct CardData: Decodable {
    var card: String
    var amount: Int
}

class Deck {
    var cards: [Card] = []
    var hand = HandSprite()
    
    var drawPile: [Card] { return cards.filter { $0.state == .deck } }
    var handPile: [Card] { return cards.filter { $0.state == .hand } }
    
    init(name: String = "") {
        if name != "" {
            cards = loadJson(filename: name)!
        }
    }
    
    func loadJson(filename: String) -> [Card]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                var cards: [Card] = []
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CardsData.self, from: data)
                for cardData in jsonData.cards {
                    if let card = CardLibrary.getCard(cardData.card) {
                        if cardData.amount > 0 {
                            for _ in 1...cardData.amount {
                                cards.append(card)
                                card.state = .deck
                            }
                        }
                    }
                }
                return cards
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func addToHand(_ name: String) -> Card? {
        if let card = CardLibrary.getCard(name) {
            cards.append(card)
            card.state = .hand
            return card
        }
        return nil
    }
    
    func draw() -> Card? { // TODO: Rename into drawRandomly, add draw(card)
        if drawPile.count > 0 {
            let shuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: drawPile)
            if let card = shuffled[0] as? Card {
                card.state = .hand
                return card
            }
        }
        return nil
    }
    
}
