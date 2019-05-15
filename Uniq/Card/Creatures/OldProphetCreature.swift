//
//  OldProphet.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class OldProphetCreature: CreatureCard {
    init() {
        super.init(attack: 1, health: 1)
        description = "Battlecry: Draw 1 card."
    }
    
    /*
    override func battlecry(battle: Battle, creature: CreatureSprite) {
        /*
        if creature.owner == .player {
            battle.player.deck.draw()
        }
        */
    }*/
}
