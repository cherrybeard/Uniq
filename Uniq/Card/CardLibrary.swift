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
        "Yletia Pirate": YletiaPirateCreature(),
        "Firelink Priest": FirelinkPriestCreature(),
        "Fairy": FairyCreature(),
        "Thug": ThugCreature(),
        "Bandit": BanditCreature(),
        
        // Spells
        "Fireball": FireballSpell(),
        "Heal": HealSpell()
    ]
    
    static func getCard(_ name: String) -> Card? {
        if let card = CardLibrary._cards[name] {
            return card.copy()
        }
        return nil
    }
}
