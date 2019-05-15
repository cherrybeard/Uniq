//
//  FireImpCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class FireImpCreature: CreatureCard {
    init() {
        super.init(attack: 3, health: 2)
        description = "Battlecry: Deal 3 damage to your hero."
    }
//    
//    override func battlecry(battle: Battle, creature: CreatureSprite) {
//        /*
//        if creature.owner == .player {
//            battle.desk.playerHero.dealDamage(3, battle: battle)
//        }
//        */
//    }
}

