//
//  SpellAnimation.swift
//  Uniq
//
//  Created by Steven Gusev on 24/02/2018.
//  Copyright © 2018 Steven Gusev. All rights reserved.
//

import SpriteKit

class SpellAnimation: Animation {
    let duration: TimeInterval = 0.2
    var target: CreatureSprite
    var damage: Int
    
    init(target: CreatureSprite, damage: Int) {
        self.target = target
        self.damage = damage
    }
    
    override func play() {
        state = .inProgress
        target.health -= damage
        state = .finished
    }
}
