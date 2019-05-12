//
//  RoyalAlchemistCreature.swift
//  Uniq
//
//  Created by Steven Gusev on 12/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import GameplayKit

class RoyalAlchemistCreature: CreatureCard {
    init() {
        super.init(attack: 4, health: 2)
        description = "Battlecry: Give random allied creature +1/+1."
    }
    
    override func battlecry(battle: Battle, creature: CreatureSprite) {
        /*
        let otherCreatures = battle.desk.creatures.filter({ c in (c != creature) && (c.owner == .player) && (c is CreatureSprite)})
        if let shuffledCreatures = GKMersenneTwisterRandomSource.sharedRandom().arrayByShufflingObjects(in: otherCreatures) as? [CreatureSprite] {
            let target = shuffledCreatures[0]
            target.increaseHealth(by: 1)
            target.increaseAttack(by: 1)
        }
        */
    }
}
