//
//  SpellCard.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import Foundation

class SpellCard: Card {
    var spell: Spell
    
    init(cost: Int, spell: Spell) {
        self.spell = spell
        super.init(cost: cost)
    }
}
