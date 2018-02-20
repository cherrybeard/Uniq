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
    var type: String
    var cost: Int
    var creature: CreatureData
}

struct CreatureData: Decodable {
    var attack: Int
    var health: Int
}

class Deck {
    var cards: [Card] = []
    
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
                    if cardData.type == "creature" {
                        let creatureData = cardData.creature
                        let creature = Creature(attack: creatureData.attack, health: creatureData.health)
                        let card = CreatureCard(cost: cardData.cost, creature: creature)
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
    
    func draw() -> Card {
        let shuffled = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: cards)
        let card = shuffled[0] as! Card
        return card
    }
}
