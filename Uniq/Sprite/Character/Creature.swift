//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class Creature {
    let sprite: CreatureSprite
    var card: CreatureCard
    var spot: Spot
    
    var health: Int
    var attack: Int
    var ability: ActiveAbility?
    var onSummon: PassiveAbility?
    var isDead: Bool { return health <= 0 }
    //var activeAbilityCooldown: Int

    var isActionTaken: Bool = false
    
    init(of card: CreatureCard, at spot: Spot) {
        self.card = card
        self.spot = spot
        health = card.health
        attack = card.attack
        if let ability = card.ability {
            self.ability = ability.copy()
        }
        onSummon = card.onSummon
        sprite = CreatureSprite(of: card)
    }
    
    /*
    func useActiveAbility(battle: Battle) -> Bool {
        if (activeAbilityCooldown == 0) && !isActionTaken {
            if card.activeAbility!.ability(battle, spot) {
                _abilityLabel.resetCooldown()
                isActionTaken = true
                return true
            }
        }
        return false
    }
    */

    func increaseAttack(by amount: Int) {
        //attack += amount
    }
    
    func dealDamage(_ amount: Int) {
        health -= amount
    }
    
    func heal(_ amount: Int) {
        //health += amount
    }
}
