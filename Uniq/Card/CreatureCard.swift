//
//  CreatureCard.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

class CreatureCard: Card {
    var creature: Creature
    
    init(cost: Int, creature: Creature) {
        self.creature = creature
        super.init(cost: cost)
    }
    
}
