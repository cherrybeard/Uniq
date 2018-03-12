//
//  FirelinkPriestCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class FirelinkPriestCreature: CreatureCard {
    init() {
        super.init(cost: 3, attack: 1, health: 1)
        description = "Battlecry: Set health to number of cards in your hand"
    }
    
    override func battlecry(battle: Battle, creature: CreatureSprite) {
        let health = battle.player.deck.handPile.count
        creature.increaseHealth(by: health)
    }
}
