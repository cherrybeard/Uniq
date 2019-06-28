//
//  CardLibrary.swift
//  Uniq
//
//  Created by Steven Gusev on 14/05/2019.
//  Copyright © 2019 Steven Gusev. All rights reserved.
//


class CardLibrary {
    private static let cards: [String: Card] = [
        
        // Creatures
        "Yletia Pirate": YletiaPirateCreature(),
        "Firelink Priest": FirelinkPriestCreature(),
        "Fairy": FairyCreature(),
        "Thug": ThugCreature(),
        "Bandit": BanditCreature(),
        
        // Spells
        "Fireball": FireballSpell(),
        "Heal": HealSpell(),
        "Backstab": BackstabSpell(),
        "Recall": RecallSpell(),
        "Mass Recall": MassRecallSpell(),
        "Taking Aim": TakingAimSpell(),
        "Fan of Knives": FanOfKnivesSpell(),
        "Assasinate": AssassinateSpell(),
        "Double Draw": DoubleDrawSpell(),
        "Whatever It Will Be": WhateverItWillBeSpell(),
        "Berserk": BerserkSpell(),
        "Magic Storm": MagicStormSpell()
    ]
    
    static func getCard(_ name: String) -> Card? {
        if let card = CardLibrary.cards[name] {
            return card.copy()
        }
        return nil
    }
    
    static func getRandomCard() -> Card? {
        return cards.randomElement()?.value
    }
    
    static func getRandomCard(filter: (Card) -> Bool) -> Card? {
        let filtered = cards.filter { filter($0.value) }
        return filtered.randomElement()?.value
    }
}
