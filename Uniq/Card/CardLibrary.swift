//
//  CardLibrary.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


class CardLibrary {
    private static let _cards: [String: Card] = [
        
        // Creatures
        "Yletia Pirate": CreatureCard(
            description: "Yletia Pirate",
            attack: 1,
            health: 4,
            ability: ActiveAbility(
                description: "Increase attack by 3",
                cooldown: 2,
                effect: { (battle: Battle, spot: Spot?) -> Bool in
                    if spot == nil { return false }
                    battle.buffStat(.attack, by: 3, at: spot!)
                    return true
                }
            )
        ),
        
        "Firelink Priest": CreatureCard(
            description: "Firelink Priest",
            attack: 1,
            health: 2,
            ability: ActiveAbility(
                description: "Give random allied creature +1/+1",
                cooldown: 2,
                effect: { (battle: Battle, spot: Spot?) -> Bool in
                    if let randomSpot = battle.randomSpot(
                        in: { ($0 != spot ) && ($0.owner == spot!.owner) && ( $0.creature != nil ) }
                    ) {
                        battle.buffStat(.attack, by: 1, at: randomSpot)
                        battle.buffStat(.health, by: 1, at: randomSpot)
                        return true
                    }
                    return false
            }
            )
        ),
        
        "Fairy": CreatureCard(
            description: "Fairy",
            attack: 0,
            health: 4
        ),
        
        "Thug": CreatureCard(
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
        
        "Bandit": CreatureCard(
            description: "Bandit",
            attack: 3,
            health: 32
        ),
        
        // Spells
        "Fireball": SpellCard (
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
        
        "Heal": SpellCard (
            description: "Heal",
            requiresTarget: true,
            spotsFilter: { $0.owner.isActive && ($0.creature?.isDamaged ?? false) },
            effect: { (battle: Battle, spot: Spot?) -> Bool in
                if spot?.creature != nil {
                    battle.heal(4, to: spot!)
                    return true
                }
                return false
            }
        )
    ]
    
    static func getCard(_ name: String) -> Card? {
        if let card = CardLibrary._cards[name] {
            return card.copy()
        }
        return nil
    }
}
