//
//  CreatureSprite.swift
//  Uniq
//
//  Created by Steven Gusev on 19/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class Creature: Character {
    let sprite: CharacterSprite
    var card: CreatureCard
    var spot: Spot
    
    var health: Value
    var attack: Value
    var ability: ActiveAbility?
    var whenSummoned: PassiveAbility?
    var onSummon: OnSummonAbility?
    var isDead: Bool { return health.current <= 0 }
    var isDamaged: Bool { return health.current < health.max }

    var isExhausted: Bool = true
    
    init(of card: CreatureCard, at spot: Spot) {
        self.card = card
        self.spot = spot
        attack = card.attack
        health = card.health
        if let ability = card.ability {
            self.ability = ability.copy()
        }
        onSummon = card.onSummon
        whenSummoned = card.whenSummoned
        sprite = CreatureSprite(of: card)
    }

    func increaseStat(stat: StatLabel.Kind, by amount: Int) -> Int {
        switch stat {
        case .attack:
            attack.current += amount
            attack.max += amount
            return attack.current
        case .health:
            health.current += amount
            health.max += amount
            return health.current
        default:
            return 0
        }
    }
    
    func setStat(stat: StatLabel.Kind, to amount: Int) {
        switch stat {
        case .attack:
            attack.current = amount
            attack.current = amount
        case .health:
            health.current = amount
            health.current = amount
        default:
            return
        }
    }
    
    func dealDamage(_ amount: Int) {
        health.current -= amount
    }
    
    func heal(_ amount: Int) -> Int {
        var healed = health.max - health.current
        if healed > amount {
            healed = amount
        }
        health.current += healed
        return healed
    }
}
