//
//  Spell.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import Foundation

enum SpellType: String {
    case damage = "Damage"
}

enum SpellTargetType: String {
    case all = "All"
    case allEnemyCreatures = "All enemy creatures"
    case enemyCreature = "Enemy creature"
}

class Spell {
    var type: SpellType
    var target: SpellTargetType
    var amount: Int
    var description: String
    
    init(type: SpellType, target: SpellTargetType, amount: Int, description: String) {
        self.type = type
        self.target = target
        self.amount = amount
        self.description = description
    }
}
