//
//  RecallSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class RecallSpell: Card {
    init() {
        super.init(cost: 0)
        description = "Return friendly creature back to hand. Reduce its cost by 2."
        requiresTarget = true
        targetFilter = CardTargetFilters.ownerCreatures
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        if let creature = target as? CreatureSprite {
            let card = creature.creature
            card.cost -= 2
            if card.cost < 0 {
                card.cost = 0
            }
            battle.player.drawSpecificCard(card)
            creature.destroyed = true
        }
    }
}
