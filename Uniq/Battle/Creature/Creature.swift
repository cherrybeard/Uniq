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

    var isActionTaken: Bool = true
    
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

    func increaseStat(stat: StatType, by amount: Int) -> Int {
        switch stat {
        case .attack:
            attack += amount
            return attack
        case .health:
            health += amount
            maxHealth += amount
            return health
        default:
            return 0
        }
    }
    
    func dealDamage(_ amount: Int) {
        health -= amount
    }
    
    func heal(_ amount: Int) -> Int {
        var healed = maxHealth - health
        if healed > amount {
            healed = amount
        }
        health += healed
        return healed
    }
}
