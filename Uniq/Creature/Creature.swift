//
//  Creature.swift
//  Uniq
//
//  Created by Steven Gusev on 18/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class Creature {
    var attack: Int
    var health: Int
    
    init(attack: Int, health: Int) {
        self.attack = attack
        self.health = health
    }
    
    init(creature: Creature) {
        attack = creature.attack
        health = creature.health
    }
}
