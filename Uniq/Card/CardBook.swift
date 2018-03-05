//
//  SpellBook.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


var SpellTargetFilters: [String: CreatureSpriteFilter] = [
    "none": { _ in false },
    "creatures": { _ in true },
    "enemy creatures": { creature in creature.owner == .computer },
    "full health creatures": { creature in creature.isFullHealth }
]

var CardBook: [String: Card] = [
    
//  SPELLS
    
    "Vitalization": SpellCard(
        cost: 2,
        target: .creature,
        description: "Double creature's health",
        effect: { targets in
            for target in targets {
                let amount = target.creature.health
                target.increaseHealth(amount: amount)
                target.health += amount
            }
        },
        targetFilter: SpellTargetFilters["creatures"]!
    ),
    "Fireball": SpellCard(
        cost: 4,
        target: .creature,
        description: "Deal 6 damage",
        effect: { targets in
            for target in targets {
                target.applyDamage(damage: 6)
                target.showDamage(damage: 6)
            }
        },
        targetFilter: SpellTargetFilters["creatures"]!
    ),
    "Chain Lightning": SpellCard(
        cost: 2,
        target: .all,
        description: "Deal 1 damage to all enemy creatures",
        effect: { targets in
            for target in targets {
                target.applyDamage(damage: 1)
                target.showDamage(damage: 1)
            }
        },
        targetFilter: SpellTargetFilters["enemy creatures"]!
    ),
    "Sudden Strike": SpellCard(
        cost: 0,
        target: .creature,
        description: "Deal 2 damage to undamaged minion",
        effect: { targets in
            for target in targets {
                target.applyDamage(damage: 2)
                target.showDamage(damage: 2)
            }
        },
        targetFilter: SpellTargetFilters["full health creatures"]!
    ),
    
//  CREATURES
    
    "Imp":          CreatureCard(cost: 1, attack: 2, health: 1),
    "Skeleton":     CreatureCard(cost: 1, attack: 1, health: 2),
    
    "Soldier":      CreatureCard(cost: 2, attack: 1, health: 3),
    "Mercenary":    CreatureCard(cost: 2, attack: 2, health: 2),
    
    "Judge":        CreatureCard(cost: 3, attack: 3, health: 3),
    "Abomination":  CreatureCard(cost: 3, attack: 2, health: 4),
    
    "Knight":       CreatureCard(cost: 4, attack: 2, health: 4),
    "Lesser Demon": CreatureCard(cost: 4, attack: 4, health: 3),
    "Thug":         CreatureCard(cost: 4, attack: 1, health: 12),
    
    "Samurai":      CreatureCard(cost: 5, attack: 4, health: 5),
    
    "Bandit":       CreatureCard(cost: 10, attack: 1, health: 24)
    
]
