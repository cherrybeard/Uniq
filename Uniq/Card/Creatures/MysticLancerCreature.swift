//
//  MysticLancerCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class MysticLancerCreature: CreatureCard {
    init() {
        super.init(attack: 2, health: 2)
        description = "Death: Restore 4 health to your hero."
    }
    
    /*
    override func deathrattle(battle: Battle, creature: CreatureSprite) {
        battle.desk.playerHero.restoreHealth(by: 4)
    }
     */
}

