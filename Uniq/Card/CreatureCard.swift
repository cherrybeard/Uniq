//
//  CreatureCardSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class CreatureCard: Card {
    var attack: Int
    var health: Int
    var ability: ActiveAbility? = nil
    var whenSummoned: PassiveAbility? = nil
    var onSummon: PassiveAbility? = nil
    var hasRush: Bool = false
    
    init(name: String, attack: Int, health: Int) {
        self.attack = attack
        self.health = health
        super.init(
            name: name,
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerFree
        )
        sprite = CreatureCardSprite()
        sprite.card = self
    }
    
    override func play(battle: Battle, spot: Spot?) -> Bool {
        if spot != nil {
            battle.summon(self, to: spot!)
            return true
        }
        return false
    }
    
    override func copy() -> CreatureCard {
        let card = CreatureCard(name: name, attack: attack, health: health)
        card.description = description
        card.ability = ability
        card.whenSummoned = whenSummoned
        card.onSummon = onSummon
        card.hasRush = hasRush
        return card
    }
}
