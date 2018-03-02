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

struct CreatureData: Decodable {
    var attack: Int
    var health: Int
}

struct SpellData: Decodable {
    var type: String
    var target: String
    var amount: Int
    var description: String
}

struct CardData: Decodable {
    var cost: Int
    var creature: CreatureData?
    var spell: SpellData?
}

class Deck {
    var cards: [Card] = []
    var drawPile: [Card] {
        get {
            return cards.filter({ (card) -> Bool in
                card.state == CardState.deck
            })
        }
    }
    
    init() {
        cards = loadJson(filename: "PlayerDeck")!
    }
    
    func loadJson(filename: String) -> [Card]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                var cards: [Card] = []
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CardsData.self, from: data)
                for cardData in jsonData.cards {
                    if cardData.creature != nil {
                        let creatureData = cardData.creature
                        let creature = Creature(attack: (creatureData?.attack)!, health: (creatureData?.health)!)
                        let card = CreatureCard(cost: cardData.cost, creature: creature)
                        cards.append(card)
                    } else if cardData.spell != nil {
                        let spellData = cardData.spell!
                        let type = SpellType(rawValue: spellData.type)!
                        let target = SpellTargetType(rawValue: spellData.target)!
                        let spell = Spell(type: type, target: target, amount: spellData.amount, description: spellData.description)
                        let card = SpellCard(cost: cardData.cost, spell: spell)
                        cards.append(card)
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
