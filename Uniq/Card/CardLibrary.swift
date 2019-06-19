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
            ability: ActiveAbility(
                description: "Increase attack by 3",
                cooldown: 2,
                effect: { (Battle, spot: Spot?) -> Bool in
                    if let creature = spot?.creature {
                        creature.increaseAttack(by: 3)
                        return true
                    }
                    return false
                }
            )
        ),
        
        "Fairy": CreatureCardBlueprint(
            description: "Fairy",
            attack: 0,
            health: 4
        ),
        
        "Thug": CreatureCardBlueprint(
            description: "Thug",
            attack: 1,
            health: 8,
            whenSummoned: PassiveAbility(
                ability: { (battle: Battle, spot: Spot?) -> Bool in
                    if let summonedPlayer = spot?.owner {
                        let enemySpots = battle.spots.filter { $0.owner != summonedPlayer }
                        for targetSpot in enemySpots {
                            battle.dealDamage(1, to: targetSpot)
                            return true
                        }
                    }
                    return false
                }
            )
        ),
        
        "Bandit": CreatureCardBlueprint(
            description: "Bandit",
            attack: 3,
            health: 32
        ),
        
        // Spells
        "Fireball": SpellCardBlueprint (
            description: "Fireball",
            requiresTarget: true,
            spotsFilter: SpotsFilters.enemyCreatures,
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                if spot != nil {
                    battle.dealDamage(6, to: spot!)
                    return true
                }
                return false
            }
        ),
        
        "Heal": SpellCardBlueprint (
            description: "Heal",
            requiresTarget: true,
            spotsFilter: SpotsFilters.ownerCreatures,
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                if spot?.creature != nil {
                    battle.heal(4, to: spot!)
                    return true
                }
                return false
            }
        )
    ]
    
    static func getCard(_ name: String) -> CardBlueprint? {
        if let card = CardLibrary._cards[name] {
            return card.copy()
        }
        return nil
    }
}
