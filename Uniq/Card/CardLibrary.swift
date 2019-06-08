//
//  CardLibrary.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


class CardLibrary {
    private static let _cards: [String: CardBlueprint] = [
        // Creatures
        
        "Yletia Pirate": CreatureCardBlueprint(
            description: "Yletia Pirate",
            attack: 1,
            health: 4,
            activeAbility: ActiveAbility(
                description: "Increase attack by 3",
                cooldown: 2,
                ability: { (Battle, spot: Spot?) -> Bool in
                if let creature = spot?.creature {
                    creature.increaseAttack(by: 3)
                    return true
                }
                return false
            })
        ),
        
        "Fairy": CreatureCardBlueprint(
            description: "Fairy",
            attack: 0,
            health: 4
        ),
        
        "Thug": CreatureCardBlueprint(
            description: "Thug",
            attack: 1,
            health: 8
        ),
        
        "Bandit": CreatureCardBlueprint(
            description: "Bandit",
            attack: 3,
            health: 32
        ),
        
        // Spells
        "Fireball": SpellCardBlueprint (
            description: "Fireball",
            spotsFilter: SpotsFilters.enemy,
            spell: { (Battle, spot: Spot?) -> Bool in
                if let creature = spot?.creature {
                    creature.dealDamage(6)
                    return true
                }
                return false
        })
    ]
    
    static func getCard(_ name: String) -> CardBlueprint? {
        if let card = CardLibrary._cards[name] {
            return card.copy()
        }
        return nil
    }
}
