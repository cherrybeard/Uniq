//
//  RecallSpell.swift
//  Uniq
//
//  Created by Steven Gusev on 07/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


class RecallSpell: SpellCard {
    init() {
        super.init(cost: 0)
        description = "Return friendly creature back to hand. Reduce its cost by 2."
        requiresTarget = true
        targetFilter = CardTargetFilters.ownerCreatures
    }
    
    override func play(battle: Battle, for owner: OwnerType, target: CharacterSprite? = nil) {
        if let creature = target as? CreatureSprite {
            let creatureCard = creature.creature
            creatureCard.cost -= 2
            if creatureCard.cost < 0 {
                creatureCard.cost = 0
            }
            battle.player.deck.draw(card: CreatureCardSprite(card: creatureCard))
            creature.destroyed = true
        }
    }
}
