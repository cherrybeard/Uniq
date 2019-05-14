//
//  CardLibrary.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


class CardLibrary {
    private static let _cards: [String: Card] = [
        //"Bounty Hunter":    BountyHunterCreature(),
        //"Old Prophet":      OldProphetCreature(),
        //"Fire Imp":         FireImpCreature(),
        //"Royal Alchemist":  RoyalAlchemistCreature(),
        //"Firelink Priest":  FirelinkPriestCreature(),
        //"Mystic Lancer":    MysticLancerCreature(),
        //"Witch":            WitchCreature(),
        
        //"Imp":          CreatureCard(attack: 2, health: 1),
        //"Skeleton":     CreatureCard(attack: 1, health: 2),
        //"Soldier":      CreatureCard(attack: 1, health: 3),
        //"Mercenary":    CreatureCard(attack: 2, health: 2),
        //"Abomination":  CreatureCard(attack: 2, health: 4),
        //"Knight":       CreatureCard(attack: 2, health: 4),
        //"Lesser Demon": CreatureCard(attack: 4, health: 3),
        //"Samurai":      CreatureCard(attack: 4, health: 5),
        
        "Yletia Pirate": CreatureCard(
            description: "Yletia Pirate",
            attack: 1,
            health: 4,
            activeAbility: ActiveAbility(
                description: "Increase attack by 3",
                cooldown: 2,
                ability: { (Battle, creature: CreatureSprite?) -> Bool in
                if creature != nil {
                    creature!.increaseAttack(by: 3)
                    return true
                }
                return false
            })
        ),
        
        "Fairy": CreatureCard(
            description: "Fairy",
            attack: 3,
            health: 4
        ),
        
        "Thug": CreatureCard(
            description: "Thug",
            attack: 1,
            health: 8
        ),
        
        "Bandit": CreatureCard(
            description: "Bandit",
            attack: 3,
            health: 32
        )
    ]
    
    static func getCard(_ name: String) -> Card? {
        if let card = CardLibrary._cards[name] {
            return card.copy()
        }
        return nil
    }
}
