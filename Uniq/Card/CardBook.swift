//
//  SpellBook.swift
//  Uniq
//
//  Created by Steven Gusev on 03/03/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//


var CardBook: [String: Card] = [
// SPELLS
    /*
    "Vitalization": VitalizationSpell(),
    "Fireball": FireballSpell(),
    "Chain Lightning": ChainLightningSpell(),
    "Sudden Strike": SuddenStrikeSpell(),
    "Spark": SparkSpell(),
    "Harmless Affair": HarmlessAffairSpell(),
    "Recall": RecallSpell(),
    */
    
//  CREATURES
    "Bounty Hunter":    BountyHunterCreature(),
    "Old Prophet":      OldProphetCreature(),
    "Fire Imp":         FireImpCreature(),
    "Royal Alchemist":  RoyalAlchemistCreature(),
    "Firelink Priest":  FirelinkPriestCreature(),
    "Mystic Lancer":    MysticLancerCreature(),
    "Witch":            WitchCreature(),
    //"Yletia Pirate":    YletiaPirate(),
    
    "Fairy":        CreatureCard(attack: 1, health: 1),
    
    "Imp":          CreatureCard(attack: 2, health: 1),
    "Skeleton":     CreatureCard(attack: 1, health: 2),
    
    "Soldier":      CreatureCard(attack: 1, health: 3),
    "Mercenary":    CreatureCard(attack: 2, health: 2),
    
    "Abomination":  CreatureCard(attack: 2, health: 4),
    
    "Knight":       CreatureCard(attack: 2, health: 4),
    "Lesser Demon": CreatureCard(attack: 4, health: 3),
    "Thug":         CreatureCard(attack: 1, health: 8),
    
    "Samurai":      CreatureCard(attack: 4, health: 5),
    
    "Bandit":       CreatureCard(attack: 3, health: 32)
    
]
