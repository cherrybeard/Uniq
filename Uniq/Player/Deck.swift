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
    
    var drawPile: [Card] {
        get { return cards.filter({ card in card.state == .deck }) }
    }
    
    var handPile: [Card] {
        get { return cards.filter({ card in card.state == .hand }) }
    }
    
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
                    if let blueprint = CardLibrary.getCard(cardData.card) {
                        if cardData.amount > 0 {
                            for _ in 1...cardData.amount {
                                cards.append(blueprint.generateSprite())
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
    
    func draw(_ card: Card) { // TODO: Rename into moveToHand?
        card.state = .hand
        hand.add(card)
    }
    
    func addToHand(_ name: String) -> Card? {
        if let blueprint = CardLibrary.getCard(name) {
            let card = blueprint.generateSprite()
            cards.append(card)
            draw(card)
            return card
        }
        return nil
    }
    
    func draw() -> Card? { // TODO: Rename into drawRandomly?
        if drawPile.count > 0 {
            let shuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: drawPile)
            if let card = shuffled[0] as? Card {
                draw(card)
                return card
            }
        }
        return nil
    }
    
}
