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
    var maxHealth: Int
    var attack: Int
    var ability: ActiveAbility?
    var onSummon: PassiveAbility?
    var isDead: Bool { return health <= 0 }
    var isDamaged: Bool { return health < maxHealth }
    //var activeAbilityCooldown: Int

    var isActionTaken: Bool = false
    
    init(of card: CreatureCard, at spot: Spot) {
        self.card = card
        self.spot = spot
        attack = card.attack
        health = card.health
        maxHealth = health
        if let ability = card.ability {
            self.ability = ability.copy()
        }
        onSummon = card.onSummon
        sprite = CreatureSprite(of: card)
    }
    
    /*
    func useAbility(battle: Battle) -> Bool {
        if (ability?.left == 0) && !isActionTaken {
            if ability!.effect(battle, spot) {
                //_abilityLabel.resetCooldown()
                isActionTaken = true
                return true
            }
        }
        return false
    }*/

    func increaseAttack(by amount: Int) {
        attack += amount
    }
    
    func dealDamage(_ amount: Int) {
        health -= amount
    }
    
    func heal(_ amount: Int) -> (Int, StatState) {
        var healed = maxHealth - health
        var state: StatState = .initial
        if healed > amount {
            state = .damaged
            healed = amount
        }
        health += healed
        return (healed, state)
    }
}
