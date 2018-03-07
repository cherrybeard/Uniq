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
    var drawPile: [Card] {
        get {
            return cards.filter({ (card) -> Bool in (card.state == .deck) })
        }
    }
    
    init() {
        cards = loadJson(filename: "NotOnlyDamageSpells")!
    }
    
    func loadJson(filename: String) -> [Card]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                var cards: [Card] = []
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CardsData.self, from: data)
                for cardData in jsonData.cards {
                    if let card = CardBook[cardData.card] {
                        cards.append(card)
                        if cardData.amount == 2 {
                            cards.append(card)
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
    
    func draw() -> Card? {
        if drawPile.count > 0 {
            let shuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: drawPile)
            let card = shuffled[0] as! Card
            return card
        } else {
            return nil
        }
    }
}
