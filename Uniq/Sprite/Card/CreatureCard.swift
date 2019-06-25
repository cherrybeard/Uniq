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
    
    init(
        description: String = "",
        attack: Int,
        health: Int,
        whenSummoned: PassiveAbility? = nil,
        ability: ActiveAbility? = nil,
        onSummon: PassiveAbility? = nil
    ) {
        self.attack = attack
        self.health = health
        self.whenSummoned = whenSummoned
        self.ability = ability
        super.init(
            description: description,
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerFree
        )
        self.sprite = CreatureCardSprite()
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
        let card = CreatureCard(
            description: description,
            attack: attack,
            health: health,
            ability: ability
        )
        return card
    }
}
