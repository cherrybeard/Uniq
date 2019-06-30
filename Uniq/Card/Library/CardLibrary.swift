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
        "Assasinate": AssassinateSpell(),
        "Anger": AngerSpell(),
        "Backstab": BackstabSpell(),
        "Berserk": BerserkSpell(),
        "Brawl": BrawlSpell(),
        "Call of Battle": CallOfBattleSpell(),
        "Chain Lightning": ChainLightningSpell(),
        "Double Draw": DoubleDrawSpell(),
        "Empathy": EmpathySpell(),
        "Fan of Knives": FanOfKnivesSpell(),
        "Fireball": FireballSpell(),
        "Harmless Affair": HarmlessAffairSpell(),
        "Heal": HealSpell(),
        "Hex": HexSpell(),
        "Holy Light": HolyLightSpell(),
        "Inner Fire": InnerFireSpell(),
        "Inner Strength": InnerStrengthSpell(),
        "Lesser Destuction": LesserDestuctionSpell(),
        "Magic Storm": MagicStormSpell(),
        "Mass Hysteria": MassHysteriaSpell(),
        "Mass Recall": MassRecallSpell(),
        "Mind Control": MindControlSpell(),
        "Mirror Image": MirrorImageSpell(),
        "Recall": RecallSpell(),
        "Taking Aim": TakingAimSpell(),
        "Reckless Assault": RecklessAssaultSpell(),
        "Secret Advantage": SecretAdvantageSpell(),
        "Silence": SilenceSpell(),
        "Tome Of Intelligence": TomeOfIntelligenceSpell(),
        "Vitalization": VitalizationSpell(),
        "Whatever It Will Be": WhateverItWillBeSpell(),
        "Whip": WhipSpell()
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
