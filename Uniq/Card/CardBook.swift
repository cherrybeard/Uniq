//
//  SpellBook.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


var CardBook: [String: Card] = [
    "Vitalization": VitalizationSpell(),
    "Fireball": FireballSpell(),
    "Chain Lightning": ChainLightningSpell(),
    "Sudden Strike": SuddenStrikeSpell(),
    "Spark": SparkSpell(),
    "Harmless Affair": HarmlessAffairSpell(),
    "Recall": RecallSpell(),
    
//  CREATURES
    "Fairy":        CreatureCard(cost: 0, attack: 1, health: 1),
    
    "Imp":          CreatureCard(cost: 1, attack: 2, health: 1),
    "Skeleton":     CreatureCard(cost: 1, attack: 1, health: 2),
    
    "Soldier":      CreatureCard(cost: 2, attack: 1, health: 3),
    "Mercenary":    CreatureCard(cost: 2, attack: 2, health: 2),
    
    "Judge":        CreatureCard(cost: 3, attack: 3, health: 3),
    "Abomination":  CreatureCard(cost: 3, attack: 2, health: 4),
    
    "Knight":       CreatureCard(cost: 4, attack: 2, health: 4),
    "Lesser Demon": CreatureCard(cost: 4, attack: 4, health: 3),
    "Thug":         CreatureCard(cost: 4, attack: 1, health: 8),
    
    "Samurai":      CreatureCard(cost: 5, attack: 4, health: 5),
    
    "Bandit":       CreatureCard(cost: 10, attack: 2, health: 32)
    
]
